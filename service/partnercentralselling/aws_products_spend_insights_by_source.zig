const AwsProductInsights = @import("aws_product_insights.zig").AwsProductInsights;

/// Source-separated spend insights that provide independent analysis for AWS
/// recommendations and partner estimates.
pub const AwsProductsSpendInsightsBySource = struct {
    /// AI-generated insights including recommended products from AWS.
    aws: ?AwsProductInsights,

    /// Partner-sourced insights derived from Pricing Calculator URLs.
    partner: ?AwsProductInsights,

    pub const json_field_names = .{
        .aws = "AWS",
        .partner = "Partner",
    };
};
