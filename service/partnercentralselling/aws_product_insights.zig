const aws = @import("aws");

const AwsProductDetails = @import("aws_product_details.zig").AwsProductDetails;
const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const PaymentFrequency = @import("payment_frequency.zig").PaymentFrequency;

/// Comprehensive spend analysis for a single source (AWS or Partner) including
/// total amounts, optimization savings, program category breakdowns, and
/// detailed product-level insights.
pub const AwsProductInsights = struct {
    /// Product-level details including costs and optimization recommendations.
    aws_products: []const AwsProductDetails,

    /// ISO 4217 currency code.
    currency_code: CurrencyCode,

    /// Time period for spend amounts.
    frequency: PaymentFrequency,

    /// Total estimated spend for this source before optimizations.
    total_amount: ?[]const u8,

    /// Spend amounts mapped to AWS programs and modernization pathways.
    total_amount_by_category: []const aws.map.StringMapEntry,

    /// Total estimated spend after applying recommended optimizations.
    total_optimized_amount: ?[]const u8,

    /// Quantified savings achievable through implementing optimizations.
    total_potential_savings_amount: ?[]const u8,

    pub const json_field_names = .{
        .aws_products = "AwsProducts",
        .currency_code = "CurrencyCode",
        .frequency = "Frequency",
        .total_amount = "TotalAmount",
        .total_amount_by_category = "TotalAmountByCategory",
        .total_optimized_amount = "TotalOptimizedAmount",
        .total_potential_savings_amount = "TotalPotentialSavingsAmount",
    };
};
