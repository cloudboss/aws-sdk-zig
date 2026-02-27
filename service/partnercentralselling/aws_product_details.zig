const AwsProductOptimization = @import("aws_product_optimization.zig").AwsProductOptimization;

/// List of AWS services with program eligibility indicators (MAP, modernization
/// pathways), cost estimates, and optimization recommendations.
pub const AwsProductDetails = struct {
    /// Baseline service cost before optimizations.
    amount: ?[]const u8,

    /// List of program and pathway categories this product is eligible for.
    categories: []const []const u8,

    /// List of specific optimization recommendations for this product.
    optimizations: []const AwsProductOptimization,

    /// Service cost after applying optimizations.
    optimized_amount: ?[]const u8,

    /// Service-specific cost reduction through optimizations.
    potential_savings_amount: ?[]const u8,

    /// AWS Partner Central product identifier used for opportunity association.
    product_code: []const u8,

    /// Pricing Calculator service code.
    service_code: ?[]const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .categories = "Categories",
        .optimizations = "Optimizations",
        .optimized_amount = "OptimizedAmount",
        .potential_savings_amount = "PotentialSavingsAmount",
        .product_code = "ProductCode",
        .service_code = "ServiceCode",
    };
};
