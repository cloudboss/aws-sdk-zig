const IntegrationType = @import("integration_type.zig").IntegrationType;

/// Contains details about a product.
pub const Product = struct {
    /// The URL to the service or product documentation about the integration with
    /// Security Hub, including how to activate the integration.
    activation_url: ?[]const u8,

    /// The categories assigned to the product.
    categories: ?[]const []const u8,

    /// The name of the company that provides the product.
    company_name: ?[]const u8,

    /// A description of the product.
    description: ?[]const u8,

    /// The types of integration that the product supports. Available values are the
    /// following.
    ///
    /// * `SEND_FINDINGS_TO_SECURITY_HUB` - The integration sends
    /// findings to Security Hub.
    ///
    /// * `RECEIVE_FINDINGS_FROM_SECURITY_HUB` - The integration
    /// receives findings from Security Hub.
    ///
    /// * `UPDATE_FINDINGS_IN_SECURITY_HUB` - The integration does not send new
    ///   findings to Security Hub, but does make updates to the findings that it
    ///   receives from Security Hub.
    integration_types: ?[]const IntegrationType,

    /// For integrations with Amazon Web Services services, the Amazon Web Services
    /// Console URL from which to activate the service.
    ///
    /// For integrations with third-party products, the Amazon Web Services
    /// Marketplace URL from which to subscribe to or purchase the product.
    marketplace_url: ?[]const u8,

    /// The ARN assigned to the product.
    product_arn: []const u8,

    /// The name of the product.
    product_name: ?[]const u8,

    /// The resource policy associated with the product.
    product_subscription_resource_policy: ?[]const u8,

    pub const json_field_names = .{
        .activation_url = "ActivationUrl",
        .categories = "Categories",
        .company_name = "CompanyName",
        .description = "Description",
        .integration_types = "IntegrationTypes",
        .marketplace_url = "MarketplaceUrl",
        .product_arn = "ProductArn",
        .product_name = "ProductName",
        .product_subscription_resource_policy = "ProductSubscriptionResourcePolicy",
    };
};
