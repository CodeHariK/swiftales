import React from 'react';
import { View, Text, ScrollView, StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { BarChart, LineChart, PieChart, PopulationPyramid, RadarChart } from 'react-native-gifted-charts';
import { useAppTheme } from '../../contexts/ThemeContext';

export function Charts() {
    const { isDark } = useAppTheme();

    // Chart data
    const data = [
        { value: 50 },
        { value: 80 },
        { value: 90 },
        { value: 70 },
    ];

    const dataWithLabels = [
        { value: 50, label: 'Q1' },
        { value: 80, label: 'Q2' },
        { value: 90, label: 'Q3' },
        { value: 70, label: 'Q4' },
    ];

    const pieData = [
        { value: 30, color: '#FF6B6B' },
        { value: 25, color: '#4ECDC4' },
        { value: 20, color: '#45B7D1' },
        { value: 15, color: '#FFA07A' },
        { value: 10, color: '#98D8C8' },
    ];

    const populationData = [
        { left: 10, right: 12 },
        { left: 9, right: 8 },
        { left: 8, right: 7 },
        { left: 7, right: 6 },
    ];

    const radarData = [50, 80, 90, 70, 60, 85];

    const textColor = isDark ? '#FFFFFF' : '#000000';
    const backgroundColor = isDark ? '#1A1A1A' : '#FFFFFF';

    return (
        <SafeAreaView style={[styles.container, { backgroundColor }]}>
            <ScrollView
                contentContainerStyle={styles.contentContainer}
                showsVerticalScrollIndicator={false}
            >
                <Text style={[styles.title, { color: textColor }]}>Charts Dashboard</Text>

                {/* Bar Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Bar Chart</Text>
                    <BarChart
                        data={dataWithLabels}
                        width={300}
                        height={200}
                        frontColor="#4ECDC4"
                        yAxisTextStyle={{ color: textColor }}
                        xAxisLabelTextStyle={{ color: textColor }}
                    />
                </View>

                {/* Line Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Line Chart</Text>
                    <LineChart
                        data={dataWithLabels}
                        width={300}
                        height={200}
                        color="#4ECDC4"
                        thickness={3}
                        yAxisTextStyle={{ color: textColor }}
                        xAxisLabelTextStyle={{ color: textColor }}
                    />
                </View>

                {/* Pie Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Pie Chart</Text>
                    <PieChart data={pieData} radius={90} />
                </View>

                {/* Horizontal Bar Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Horizontal Bar Chart</Text>
                    <BarChart
                        data={dataWithLabels}
                        width={300}
                        height={200}
                        horizontal
                        frontColor="#FF6B6B"
                        yAxisTextStyle={{ color: textColor }}
                        xAxisLabelTextStyle={{ color: textColor }}
                    />
                </View>

                {/* Area Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Area Chart</Text>
                    <LineChart
                        data={dataWithLabels}
                        width={300}
                        height={200}
                        areaChart
                        color="#45B7D1"
                        thickness={3}
                        yAxisTextStyle={{ color: textColor }}
                        xAxisLabelTextStyle={{ color: textColor }}
                    />
                </View>

                {/* Donut Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Donut Chart</Text>
                    <PieChart data={pieData} radius={90} donut />
                </View>

                {/* Population Pyramid */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Population Pyramid</Text>
                    <PopulationPyramid data={populationData} width={300} height={200} />
                </View>

                {/* Radar Chart */}
                <View style={[styles.chartContainer, { backgroundColor: isDark ? '#2A2A2A' : '#F5F5F5' }]}>
                    <Text style={[styles.chartTitle, { color: textColor }]}>Radar Chart</Text>
                    <RadarChart data={radarData} />
                </View>
            </ScrollView>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    contentContainer: {
        padding: 20,
        paddingBottom: 40,
        alignItems: 'center',
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        marginBottom: 30,
        textAlign: 'center',
    },
    chartContainer: {
        padding: 20,
        borderRadius: 12,
        marginBottom: 30,
        alignItems: 'center',
        shadowColor: '#000',
        shadowOffset: {
            width: 0,
            height: 2,
        },
        shadowOpacity: 0.1,
        shadowRadius: 3.84,
        elevation: 5,
    },
    chartTitle: {
        fontSize: 18,
        fontWeight: '600',
        marginBottom: 15,
    },
});

