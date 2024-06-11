import RecentBlockhashesPageClient from './page-client';

type Props = Readonly<{
    params: {
        address: string;
    };
}>;

export const metadata = {
    description: `Recent blockhashes on Yona`,
    title: `Recent Blockhashes | Yona`,
};

export default function RecentBlockhashesPage(props: Props) {
    return <RecentBlockhashesPageClient {...props} />;
}
