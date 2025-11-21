import React, { useCallback, useMemo, useRef, useState } from 'react';
import { StyleSheet, View, Text, TouchableOpacity, Animated } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import PagerView, {
    type PageScrollStateChangedNativeEvent,
    type PagerViewOnPageScrollEventData,
    type PagerViewOnPageSelectedEventData,
} from 'react-native-pager-view';
import { useAppTheme } from '../../contexts/ThemeContext';

const AnimatedPagerView = Animated.createAnimatedComponent(PagerView);

const BGCOLOR = ['#fdc08e', '#fff6b9', '#99d1b7', '#dde5fe', '#f79273'];

type Page = {
    key: number;
    backgroundColor: string;
};

const createPage = (key: number): Page => ({
    key,
    backgroundColor: BGCOLOR[key % BGCOLOR.length],
});

export function Pager() {
    const { isDark } = useAppTheme();
    const ref = useRef<PagerView>(null);
    const [pages, setPages] = useState<Page[]>(useMemo(() => {
        return new Array(5).fill('').map((_, index) => createPage(index));
    }, []));
    const [activePage, setActivePage] = useState(0);
    const [isAnimated, setIsAnimated] = useState(true);
    const [scrollEnabled, setScrollEnabled] = useState(true);
    const [scrollState, setScrollState] = useState('idle');
    const [progress, setProgress] = useState({ position: 0, offset: 0 });

    const onPageScrollOffset = useRef(new Animated.Value(0)).current;
    const onPageScrollPosition = useRef(new Animated.Value(0)).current;
    const onPageSelectedPosition = useRef(new Animated.Value(0)).current;

    const setPage = useCallback(
        (page: number) => {
            if (page < 0 || page >= pages.length) return;
            isAnimated
                ? ref.current?.setPage(page)
                : ref.current?.setPageWithoutAnimation(page);
        },
        [isAnimated, pages.length]
    );

    const addPage = useCallback(() => {
        setPages((prevPages) => [...prevPages, createPage(prevPages.length)]);
    }, []);

    const removePage = useCallback(() => {
        setPages((prevPages) => {
            if (prevPages.length === 1) return prevPages;
            const newPages = prevPages.slice(0, prevPages.length - 1);
            if (activePage >= newPages.length) {
                setPage(newPages.length - 1);
            }
            return newPages;
        });
    }, [activePage, setPage]);

    const onPageScroll = useMemo(
        () =>
            Animated.event<PagerViewOnPageScrollEventData>(
                [
                    {
                        nativeEvent: {
                            offset: onPageScrollOffset,
                            position: onPageScrollPosition,
                        },
                    },
                ],
                {
                    listener: ({ nativeEvent: { offset, position } }) => {
                        setProgress({ position, offset });
                    },
                    useNativeDriver: true,
                }
            ),
        []
    );

    const onPageSelected = useMemo(
        () =>
            Animated.event<PagerViewOnPageSelectedEventData>(
                [{ nativeEvent: { position: onPageSelectedPosition } }],
                {
                    listener: ({ nativeEvent: { position } }) => {
                        setActivePage(position);
                    },
                    useNativeDriver: true,
                }
            ),
        []
    );

    const onPageScrollStateChanged = useCallback(
        (e: PageScrollStateChangedNativeEvent) => {
            setScrollState(e.nativeEvent.pageScrollState);
        },
        []
    );

    const firstPage = useCallback(() => setPage(0), [setPage]);
    const prevPage = useCallback(() => setPage(activePage - 1), [activePage, setPage]);
    const nextPage = useCallback(() => setPage(activePage + 1), [activePage, setPage]);
    const lastPage = useCallback(() => setPage(pages.length - 1), [pages.length, setPage]);

    const textColor = isDark ? '#FFFFFF' : '#000000';
    const backgroundColor = isDark ? '#1A1A1A' : '#FFFFFF';
    const buttonBg = isDark ? '#2A2A2A' : '#E0E0E0';
    const buttonTextColor = isDark ? '#FFFFFF' : '#000000';

    return (
        <SafeAreaView style={[styles.container, { backgroundColor }]}>
            <AnimatedPagerView
                ref={ref}
                style={styles.pagerView}
                initialPage={0}
                pageMargin={10}
                scrollEnabled={scrollEnabled}
                onPageScroll={onPageScroll}
                onPageSelected={onPageSelected}
                onPageScrollStateChanged={onPageScrollStateChanged}
            >
                {pages.map((page, index) => (
                    <View
                        key={page.key}
                        style={[
                            styles.page,
                            { backgroundColor: page.backgroundColor },
                        ]}
                    >
                        <Text style={[styles.pageText, { color: textColor }]}>
                            Page {index + 1}
                        </Text>
                        <Text style={[styles.pageSubtext, { color: textColor }]}>
                            Swipe left or right to navigate
                        </Text>
                    </View>
                ))}
            </AnimatedPagerView>

            {/* Controls Panel */}
            <View style={[styles.controlsPanel, { backgroundColor: buttonBg }]}>
                <View style={styles.controlRow}>
                    <TouchableOpacity
                        style={[styles.button, { backgroundColor: buttonBg }]}
                        onPress={() => setScrollEnabled(!scrollEnabled)}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            {scrollEnabled ? 'Scroll: ON' : 'Scroll: OFF'}
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                        style={[styles.button, { backgroundColor: buttonBg }]}
                        onPress={() => setIsAnimated(!isAnimated)}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            {isAnimated ? 'Anim: ON' : 'Anim: OFF'}
                        </Text>
                    </TouchableOpacity>
                </View>

                <View style={styles.controlRow}>
                    <TouchableOpacity
                        style={[styles.button, { backgroundColor: buttonBg }]}
                        onPress={addPage}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            Add Page
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                        style={[styles.button, { backgroundColor: buttonBg }]}
                        onPress={removePage}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            Remove Page
                        </Text>
                    </TouchableOpacity>
                </View>

                <View style={styles.controlRow}>
                    <TouchableOpacity
                        style={[styles.button, styles.navButton, { backgroundColor: buttonBg }]}
                        onPress={firstPage}
                        disabled={activePage === 0}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            First
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                        style={[styles.button, styles.navButton, { backgroundColor: buttonBg }]}
                        onPress={prevPage}
                        disabled={activePage === 0}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            Prev
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                        style={[styles.button, styles.navButton, { backgroundColor: buttonBg }]}
                        onPress={nextPage}
                        disabled={activePage === pages.length - 1}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            Next
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                        style={[styles.button, styles.navButton, { backgroundColor: buttonBg }]}
                        onPress={lastPage}
                        disabled={activePage === pages.length - 1}
                    >
                        <Text style={[styles.buttonText, { color: buttonTextColor }]}>
                            Last
                        </Text>
                    </TouchableOpacity>
                </View>

                <View style={styles.infoRow}>
                    <Text style={[styles.infoText, { color: textColor }]}>
                        Page {activePage + 1} / {pages.length}
                    </Text>
                    <Text style={[styles.infoText, { color: textColor }]}>
                        State: {scrollState}
                    </Text>
                </View>
            </View>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    pagerView: {
        flex: 1,
    },
    page: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 20,
    },
    pageText: {
        fontSize: 32,
        fontWeight: 'bold',
        marginBottom: 10,
    },
    pageSubtext: {
        fontSize: 18,
        marginTop: 10,
    },
    controlsPanel: {
        padding: 10,
        borderTopWidth: 1,
        borderTopColor: '#E0E0E0',
    },
    controlRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 10,
        gap: 10,
    },
    button: {
        flex: 1,
        padding: 12,
        borderRadius: 8,
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: 44,
    },
    navButton: {
        flex: 1,
    },
    buttonText: {
        fontSize: 14,
        fontWeight: '600',
    },
    infoRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginTop: 5,
        paddingTop: 10,
        borderTopWidth: 1,
        borderTopColor: '#E0E0E0',
    },
    infoText: {
        fontSize: 14,
        fontWeight: '500',
    },
});
