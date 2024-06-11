import { Metadata } from 'next/types';
import React from 'react';

type Props = Readonly<{
    children: React.ReactNode;
    params: Readonly<{
        signature: string;
    }>;
}>;

export async function generateMetadata({ params: { signature } }: Props): Promise<Metadata> {
    if (signature) {
        return {
            description: `Interactively inspect the Yona transaction with signature ${signature}`,
            title: `Transaction Inspector | ${signature} | Yona`,
        };
    } else {
        return {
            description: `Interactively inspect Yona transactions`,
            title: `Transaction Inspector | Yona`,
        };
    }
}

export default function TransactionInspectorLayout({ children }: Props) {
    return children;
}
