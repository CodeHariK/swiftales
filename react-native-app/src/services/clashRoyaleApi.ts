const API_BASE_URL = 'https://api.clashroyale.com/v1';

export interface ClashRoyaleCard {
  id: number;
  name: string;
  maxLevel: number;
  maxEvolutionLevel?: number;
  elixirCost?: number;
  iconUrls: {
    medium: string;
    evolutionMedium?: string;
  };
  rarity?: string;
  type?: string;
}

export interface ClashRoyaleCardsResponse {
  items: ClashRoyaleCard[];
}

export async function fetchClashRoyaleCards(limit: number = 10): Promise<ClashRoyaleCardsResponse> {
  // In Expo, environment variables must be prefixed with EXPO_PUBLIC_ to be accessible
  // Check both EXPO_PUBLIC_ and regular env var for flexibility
  const apiKey = 
    process.env.EXPO_PUBLIC_CLASH_ROYALE_API_KEY || 
    process.env.CLASH_ROYALE_API_KEY ||
    (global as any).CLASH_ROYALE_API_KEY;
  
  if (!apiKey) {
    throw new Error('CLASH_ROYALE_API_KEY is not set. Please set EXPO_PUBLIC_CLASH_ROYALE_API_KEY in your .env file or environment variables.');
  }

  const response = await fetch(`${API_BASE_URL}/cards?limit=${limit}`, {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Accept': 'application/json',
    },
  });

  if (!response.ok) {
    let errorMessage = `API Error: ${response.status} ${response.statusText}`;
    
    try {
      const errorData = await response.json();
      if (errorData.reason === 'accessDenied.invalidIp') {
        const ipAddress = errorData.message?.match(/\d+\.\d+\.\d+\.\d+/)?.[0] || 'unknown';
        errorMessage = `IP Whitelisting Required: Your current IP (${ipAddress}) is not whitelisted. The Clash Royale API does not support "0.0.0.0/0" to allow all IPs. You must whitelist specific IP addresses. For mobile apps, use a backend server or proxy service.`;
      } else {
        errorMessage = errorData.message || errorData.reason || errorMessage;
      }
    } catch {
      // If response is not JSON, use status text
      const errorText = await response.text();
      errorMessage = `${errorMessage}. ${errorText.substring(0, 200)}`;
    }
    
    throw new Error(errorMessage);
  }

  const data = await response.json();
  
  // Clash Royale API returns items directly as an array
  if (Array.isArray(data)) {
    return { items: data };
  }
  
  // Or wrapped in items property
  if (data.items && Array.isArray(data.items)) {
    return data;
  }
  
  throw new Error('Unexpected API response format');
}

