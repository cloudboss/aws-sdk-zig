const EntitlementValue = @import("entitlement_value.zig").EntitlementValue;

/// An entitlement represents capacity in a product owned by the customer. For
/// example, a
/// customer might own some number of users or seats in an SaaS application or
/// some amount of
/// data capacity in a multi-tenant database.
pub const Entitlement = struct {
    /// The `CustomerAWSAccountID` parameter specifies the AWS account ID of the
    /// buyer.
    customer_aws_account_id: ?[]const u8 = null,

    /// The customer identifier is a handle to each unique customer in an
    /// application. Customer
    /// identifiers are obtained through the ResolveCustomer operation in AWS
    /// Marketplace Metering
    /// Service.
    customer_identifier: ?[]const u8 = null,

    /// The dimension for which the given entitlement applies. Dimensions represent
    /// categories of
    /// capacity in a product and are specified when the product is listed in AWS
    /// Marketplace.
    dimension: ?[]const u8 = null,

    /// The expiration date represents the minimum date through which this
    /// entitlement is
    /// expected to remain valid. For contractual products listed on AWS
    /// Marketplace, the expiration date
    /// is the date at which the customer will renew or cancel their contract.
    /// Customers who are opting
    /// to renew their contract will still have entitlements with an expiration
    /// date.
    expiration_date: ?i64 = null,

    /// The product code for which the given entitlement applies. Product codes are
    /// provided by
    /// AWS Marketplace when the product listing is created.
    product_code: ?[]const u8 = null,

    /// The EntitlementValue represents the amount of capacity that the customer is
    /// entitled to
    /// for the product.
    value: ?EntitlementValue = null,

    pub const json_field_names = .{
        .customer_aws_account_id = "CustomerAWSAccountId",
        .customer_identifier = "CustomerIdentifier",
        .dimension = "Dimension",
        .expiration_date = "ExpirationDate",
        .product_code = "ProductCode",
        .value = "Value",
    };
};
