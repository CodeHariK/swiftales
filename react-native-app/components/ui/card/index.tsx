'use client';
import React from 'react';
import { View, Pressable, Text, Image, ImageProps } from 'react-native';
import {
    tva,
    type VariantProps,
} from '@gluestack-ui/utils/nativewind-utils';
import { cssInterop } from 'nativewind';

const cardStyle = tva({
    base: 'rounded-lg border border-outline-200 bg-background-0 p-4 shadow-sm',
    variants: {
        variant: {
            elevated: 'shadow-md',
            outlined: 'border-2',
            filled: 'bg-background-50',
        },
        size: {
            sm: 'p-3',
            md: 'p-4',
            lg: 'p-6',
        },
    },
    defaultVariants: {
        variant: 'elevated',
        size: 'md',
    },
});

const cardHeaderStyle = tva({
    base: 'mb-3',
});

const cardBodyStyle = tva({
    base: 'mb-3',
});

const cardFooterStyle = tva({
    base: 'mt-3',
});

type ICardProps = React.ComponentPropsWithoutRef<typeof Pressable> &
    VariantProps<typeof cardStyle> & {
        className?: string;
    };

const Card = React.forwardRef<React.ElementRef<typeof Pressable>, ICardProps>(
    ({ className, variant, size, ...props }, ref) => {
        return (
            <Pressable
                ref={ref}
                className={cardStyle({ variant, size, class: className })}
                {...props}
            />
        );
    }
);

const CardHeader = React.forwardRef<
    React.ElementRef<typeof View>,
    React.ComponentPropsWithoutRef<typeof View> & { className?: string }
>(({ className, ...props }, ref) => {
    return (
        <View
            ref={ref}
            className={cardHeaderStyle({ class: className })}
            {...props}
        />
    );
});

const CardBody = React.forwardRef<
    React.ElementRef<typeof View>,
    React.ComponentPropsWithoutRef<typeof View> & { className?: string }
>(({ className, ...props }, ref) => {
    return (
        <View
            ref={ref}
            className={cardBodyStyle({ class: className })}
            {...props}
        />
    );
});

const CardFooter = React.forwardRef<
    React.ElementRef<typeof View>,
    React.ComponentPropsWithoutRef<typeof View> & { className?: string }
>(({ className, ...props }, ref) => {
    return (
        <View
            ref={ref}
            className={cardFooterStyle({ class: className })}
            {...props}
        />
    );
});

Card.displayName = 'Card';
CardHeader.displayName = 'CardHeader';
CardBody.displayName = 'CardBody';
CardFooter.displayName = 'CardFooter';

export { Card, CardHeader, CardBody, CardFooter };

