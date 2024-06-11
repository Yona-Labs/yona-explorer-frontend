import StakeHistoryPageClient from './page-client';

type Props = Readonly<{
    params: {
        address: string;
    };
}>;

export const metadata = {
    description: `Stake history for each epoch on Yona`,
    title: `Stake History | Yona`,
};

export default function StakeHistoryPage(props: Props) {
    return <StakeHistoryPageClient {...props} />;
}
