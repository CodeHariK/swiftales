import React from 'react';
import { View, Text, ScrollView, StyleSheet, Image } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StaticScreenProps } from '@react-navigation/native';
import { useQuery } from '@tanstack/react-query';
import { fetchClashRoyaleCards, type ClashRoyaleCard } from '../../../services/clashRoyaleApi';
import { useAppTheme } from '../../../contexts/ThemeContext';
import { Card, CardHeader, CardBody } from '@/components/ui/card';

type CardInfoScreenProps = StaticScreenProps<{
    cardName: string;
}>;

export function ClashInfo({ route }: CardInfoScreenProps) {
    const { isDark } = useAppTheme();
    const { cardName } = route.params;
    const textColor = isDark ? '#FFFFFF' : '#000000';
    const backgroundColor = isDark ? '#1A1A1A' : '#FFFFFF';
    const cardBg = isDark ? '#2A2A2A' : '#F5F5F5';
    const borderColor = isDark ? '#444' : '#E0E0E0';

    const { data, isLoading } = useQuery({
        queryKey: ['clashRoyaleCards'],
        queryFn: () => fetchClashRoyaleCards(100), // Get more cards to find the matching one
    });

    const card = data?.items?.find((c: ClashRoyaleCard) => c.name === cardName);

    if (isLoading) {
        return (
            <SafeAreaView style={[styles.container, { backgroundColor }]}>
                <View style={styles.loadingContainer}>
                    <Text style={[styles.loadingText, { color: textColor }]}>Loading card info...</Text>
                </View>
            </SafeAreaView>
        );
    }

    if (!card) {
        return (
            <SafeAreaView style={[styles.container, { backgroundColor }]}>
                <ScrollView contentContainerStyle={styles.errorContainer}>
                    <Text style={[styles.errorText, { color: textColor }]}>Card not found</Text>
                    <Text style={[styles.errorDetail, { color: textColor }]}>
                        Could not find card: {cardName}
                    </Text>
                </ScrollView>
            </SafeAreaView>
        );
    }

    return (
        <SafeAreaView style={[styles.container, { backgroundColor }]}>
            <ScrollView
                style={styles.scrollView}
                contentContainerStyle={styles.contentContainer}
            >
                <Card variant="elevated" size="lg">
                    <CardBody style={{ alignItems: 'center', padding: 24 }}>
                        <View style={styles.imageContainer}>
                            {card.iconUrls?.medium && (
                                <View style={styles.imageWrapper}>
                                    <Text style={[styles.imageLabel, { color: textColor }]}>Standard</Text>
                                    <Image
                                        source={{ uri: card.iconUrls.medium }}
                                        style={styles.cardImage}
                                        resizeMode="contain"
                                    />
                                </View>
                            )}
                            {card.iconUrls?.evolutionMedium && (
                                <View style={styles.imageWrapper}>
                                    <Text style={[styles.imageLabel, { color: textColor }]}>Evolution</Text>
                                    <Image
                                        source={{ uri: card.iconUrls.evolutionMedium }}
                                        style={styles.cardImage}
                                        resizeMode="contain"
                                    />
                                </View>
                            )}
                        </View>
                        <Text style={[styles.cardName, { color: textColor }]}>{card.name}</Text>
                    </CardBody>
                </Card>

                <Card variant="outlined" style={{ marginTop: 20 }}>
                    <CardHeader>
                        <Text style={[styles.sectionTitle, { color: textColor }]}>Card Details</Text>
                    </CardHeader>
                    <CardBody>

                        {card.maxLevel !== undefined && (
                            <View style={styles.infoRow}>
                                <Text style={[styles.infoLabel, { color: textColor }]}>Max Level:</Text>
                                <Text style={[styles.infoValue, { color: textColor }]}>{card.maxLevel}</Text>
                            </View>
                        )}

                        {card.elixirCost !== undefined && (
                            <View style={styles.infoRow}>
                                <Text style={[styles.infoLabel, { color: textColor }]}>Elixir Cost:</Text>
                                <Text style={[styles.infoValue, { color: textColor }]}>{card.elixirCost}</Text>
                            </View>
                        )}

                        {card.maxEvolutionLevel !== undefined && (
                            <View style={styles.infoRow}>
                                <Text style={[styles.infoLabel, { color: textColor }]}>Max Evolution Level:</Text>
                                <Text style={[styles.infoValue, { color: textColor }]}>{card.maxEvolutionLevel}</Text>
                            </View>
                        )}

                        {card.rarity && (
                            <View style={styles.infoRow}>
                                <Text style={[styles.infoLabel, { color: textColor }]}>Rarity:</Text>
                                <Text style={[styles.infoValue, { color: textColor }]}>{card.rarity}</Text>
                            </View>
                        )}

                        {card.type && (
                            <View style={styles.infoRow}>
                                <Text style={[styles.infoLabel, { color: textColor }]}>Type:</Text>
                                <Text style={[styles.infoValue, { color: textColor }]}>{card.type}</Text>
                            </View>
                        )}

                        {card.id !== undefined && (
                            <View style={styles.infoRow}>
                                <Text style={[styles.infoLabel, { color: textColor }]}>Card ID:</Text>
                                <Text style={[styles.infoValue, { color: textColor }]}>{card.id}</Text>
                            </View>
                        )}
                    </CardBody>
                </Card>
            </ScrollView>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    scrollView: {
        flex: 1,
    },
    contentContainer: {
        padding: 20,
        paddingBottom: 40,
    },
    loadingContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    loadingText: {
        fontSize: 16,
    },
    errorContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 20,
    },
    errorText: {
        fontSize: 20,
        fontWeight: 'bold',
        marginBottom: 10,
    },
    errorDetail: {
        fontSize: 14,
        textAlign: 'center',
    },
    imageContainer: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        gap: 20,
        marginBottom: 16,
        flexWrap: 'wrap',
    },
    imageWrapper: {
        alignItems: 'center',
        gap: 8,
    },
    imageLabel: {
        fontSize: 14,
        fontWeight: '600',
        textTransform: 'uppercase',
    },
    cardImage: {
        width: 150,
        height: 150,
    },
    cardName: {
        fontSize: 32,
        fontWeight: 'bold',
        textAlign: 'center',
    },
    sectionTitle: {
        fontSize: 24,
        fontWeight: 'bold',
        marginBottom: 16,
    },
    infoRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingVertical: 12,
        borderBottomWidth: 1,
        borderBottomColor: 'rgba(0,0,0,0.1)',
    },
    infoLabel: {
        fontSize: 16,
        fontWeight: '600',
        flex: 1,
    },
    infoValue: {
        fontSize: 16,
        flex: 1,
        textAlign: 'right',
    },
});

