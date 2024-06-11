import SupplyPageClient from './page-client';

export const metadata = {
    description: `Overview of the native token supply on Yona`,
    title: `Supply Overview | Yona`,
};

export default function SupplyPage() {
    return <SupplyPageClient />;
}
