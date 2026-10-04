/// Represents other entities related to the AWS opportunity, such as AWS
/// products, partner solutions, and marketplace offers. These associations help
/// build a complete picture of the solution being sold.
pub const AwsOpportunityRelatedEntities = struct {
    /// The AWS Marketplace product ARNs associated with this opportunity.
    aws_marketplace_products: ?[]const []const u8 = null,

    /// The AWS Marketplace solution ARNs associated with this opportunity.
    aws_marketplace_solutions: ?[]const []const u8 = null,

    /// Specifies the AWS products associated with the opportunity. This field helps
    /// track the specific products that are part of the proposed solution.
    aws_products: ?[]const []const u8 = null,

    /// Specifies the partner solutions related to the opportunity. These solutions
    /// represent the partner's offerings that are being positioned as part of the
    /// overall AWS opportunity.
    solutions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .aws_marketplace_products = "AwsMarketplaceProducts",
        .aws_marketplace_solutions = "AwsMarketplaceSolutions",
        .aws_products = "AwsProducts",
        .solutions = "Solutions",
    };
};
