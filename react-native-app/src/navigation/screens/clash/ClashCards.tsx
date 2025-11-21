import React from 'react';
import { View, Text, ScrollView, StyleSheet, Image, ActivityIndicator, RefreshControl, FlatList, Dimensions } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useQuery } from '@tanstack/react-query';
import { useNavigation } from '@react-navigation/native';
import type { NavigationProp } from '@react-navigation/native';
import { fetchClashRoyaleCards, type ClashRoyaleCard } from '../../../services/clashRoyaleApi';
import { useAppTheme } from '../../../contexts/ThemeContext';
import { Card, CardHeader, CardBody } from '@/components/ui/card';
import { Button, ButtonText } from '@/components/ui/button';
import { HStack } from '@/components/ui/hstack';

const { width } = Dimensions.get('window');
const CARD_MARGIN = 10;
const CARDS_PER_ROW = 2;
const CARD_WIDTH = (width - (CARD_MARGIN * (CARDS_PER_ROW + 1))) / CARDS_PER_ROW;

export function ClashCards() {
    const { isDark } = useAppTheme();
    const navigation = useNavigation<NavigationProp<any>>();
    const textColor = isDark ? '#FFFFFF' : '#000000';
    const backgroundColor = isDark ? '#1A1A1A' : '#FFFFFF';
    const cardBg = isDark ? '#2A2A2A' : '#F5F5F5';
    const borderColor = isDark ? '#444' : '#E0E0E0';

    const { data, isLoading, error, refetch, isRefetching } = useQuery({
        queryKey: ['clashRoyaleCards'],
        queryFn: () => fetchClashRoyaleCards(10),
        retry: 2,
    });

    const handleCardPress = (card: ClashRoyaleCard) => {
        navigation.navigate('ClashInfo', { cardName: card.name });
    };

    const renderCard = ({ item }: { item: ClashRoyaleCard }) => (
        <View style={{ width: CARD_WIDTH, marginBottom: CARD_MARGIN }}>
            <Card
                variant="elevated"
                size="sm"
                onPress={() => handleCardPress(item)}
                style={{ width: '100%' }}
            >
                <CardBody style={{ alignItems: 'center', padding: 8 }}>
                    {item.iconUrls?.medium && (
                        <Image
                            source={{ uri: item.iconUrls.medium }}
                            style={styles.gridCardIcon}
                            resizeMode="contain"
                        />
                    )}

                    <HStack space="md" reversed={false}>

                        <Text style={[styles.gridCardName, { color: textColor }]} numberOfLines={2}>
                            {item.name}
                        </Text>

                        {item.elixirCost !== undefined && (
                            <Text style={[styles.gridCardElixir, { color: textColor }]}>
                                {item.elixirCost} ⚡
                            </Text>
                        )}

                    </HStack>
                </CardBody>
            </Card>
        </View>
    );

    if (isLoading) {
        return (
            <SafeAreaView style={[styles.container, { backgroundColor }]}>
                <View style={styles.loadingContainer}>
                    <ActivityIndicator size="large" color={isDark ? '#FFFFFF' : '#000000'} />
                    <Text style={[styles.loadingText, { color: textColor }]}>Loading cards...</Text>
                </View>
            </SafeAreaView>
        );
    }

    if (error) {
        const errorMessage = error instanceof Error ? error.message : 'Unknown error';
        const isIpError = errorMessage.includes('IP Whitelisting Required') || errorMessage.includes('invalidIp');

        return (
            <SafeAreaView style={[styles.container, { backgroundColor }]}>
                <ScrollView
                    contentContainerStyle={styles.errorContainer}
                    refreshControl={
                        <RefreshControl refreshing={isRefetching} onRefresh={() => refetch()} />
                    }
                >
                    <Text style={[styles.errorText, { color: textColor }]}>
                        {isIpError ? 'IP Whitelisting Required' : 'Error loading cards'}
                    </Text>
                    <Text style={[styles.errorDetail, { color: textColor }]}>
                        {errorMessage}
                    </Text>
                    {isIpError && (
                        <Card variant="outlined" style={{ marginTop: 20 }}>
                            <CardHeader>
                                <Text style={[styles.solutionTitle, { color: textColor }]}>
                                    Solutions:
                                </Text>
                            </CardHeader>
                            <CardBody>
                                <Text style={[styles.solutionText, { color: textColor }]}>
                                    1. Add your current IP to the Developer Portal (temporary solution){'\n'}
                                    2. Use a backend server with a static whitelisted IP (recommended){'\n'}
                                    3. Use RoyaleAPI proxy service (easiest for mobile apps){'\n'}
                                    4. Note: Clash Royale API doesn't support wildcard IPs
                                </Text>
                            </CardBody>
                        </Card>
                    )}
                    <Button
                        action="primary"
                        variant="outline"
                        size="md"
                        onPress={() => refetch()}
                        style={{ marginTop: 20 }}
                    >
                        <ButtonText>Retry</ButtonText>
                    </Button>
                    <Text style={[styles.hintText, { color: textColor }]}>
                        Or pull down to retry
                    </Text>
                </ScrollView>
            </SafeAreaView>
        );
    }

    return (
        <SafeAreaView style={[styles.container, { backgroundColor }]} edges={['bottom', 'left', 'right']}>
            <View style={styles.header}>
                <Text style={[styles.subtitle, { color: textColor }]}>
                    {data?.items?.length || 0} cards loaded
                </Text>
            </View>
            <FlatList
                data={data?.items || []}
                renderItem={renderCard}
                keyExtractor={(item) => item.id.toString()}
                numColumns={CARDS_PER_ROW}
                contentContainerStyle={styles.gridContainer}
                columnWrapperStyle={styles.row}
                refreshControl={
                    <RefreshControl refreshing={isRefetching} onRefresh={() => refetch()} />
                }
                ListEmptyComponent={
                    <View style={styles.emptyContainer}>
                        <Text style={[styles.emptyText, { color: textColor }]}>No cards found</Text>
                    </View>
                }
            />
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    header: {
        paddingTop: 8,
        paddingBottom: 8,
        paddingHorizontal: 20,
    },
    gridContainer: {
        padding: CARD_MARGIN,
        paddingBottom: 40,
    },
    row: {
        justifyContent: 'space-between',
        marginBottom: CARD_MARGIN,
    },
    loadingContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    loadingText: {
        marginTop: 10,
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
        marginBottom: 10,
    },
    hintText: {
        fontSize: 12,
        fontStyle: 'italic',
        marginTop: 10,
    },
    solutionBox: {
        marginTop: 20,
        padding: 16,
        borderRadius: 8,
        borderWidth: 1,
    },
    solutionTitle: {
        fontSize: 16,
        fontWeight: 'bold',
        marginBottom: 8,
    },
    solutionText: {
        fontSize: 14,
        lineHeight: 20,
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        marginBottom: 10,
        textAlign: 'center',
    },
    subtitle: {
        fontSize: 16,
        textAlign: 'center',
    },
    gridCardIcon: {
        width: CARD_WIDTH - 40,
        height: CARD_WIDTH - 40,
        marginBottom: 8,
    },
    gridCardName: {
        fontSize: 14,
        fontWeight: 'bold',
        textAlign: 'center',
        marginBottom: 4,
    },
    gridCardElixir: {
        fontSize: 12,
        textAlign: 'center',
    },
    emptyContainer: {
        padding: 40,
        alignItems: 'center',
    },
    emptyText: {
        fontSize: 16,
    },
});

