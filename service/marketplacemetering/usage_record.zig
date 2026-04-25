const UsageAllocation = @import("usage_allocation.zig").UsageAllocation;

/// A `UsageRecord` indicates a quantity of usage for a given product,
/// customer, dimension and time.
///
/// Multiple requests with the same `UsageRecords` as input will be
/// de-duplicated to prevent double charges.
pub const UsageRecord = struct {
    /// The `CustomerAWSAccountId` parameter specifies the AWS account ID of the
    /// buyer.
    ///
    /// For existing integrations, to access your `CustomerIdentifier` to
    /// `CustomerAWSAccountId` mapping, see [Account
    /// Feeds](https://docs.aws.amazon.com/marketplace/latest/userguide/data-feed-account.html).
    customer_aws_account_id: ?[]const u8 = null,

    /// The `CustomerIdentifier` is obtained through the
    /// `ResolveCustomer` operation and represents an individual buyer in your
    /// application.
    customer_identifier: []const u8 = "",

    /// During the process of registering a product on Amazon Web Services
    /// Marketplace, dimensions are specified.
    /// These represent different units of value in your application.
    dimension: []const u8,

    /// The `LicenseArn` is a unique identifier for a specific granted license.
    /// These are used for software purchased through Amazon Web Services
    /// Marketplace.
    ///
    /// To access your `CustomerAWSAccountId` and `LicenseArn` mapping, visit
    /// [Agreements
    /// Feeds](https://docs.aws.amazon.com/marketplace/latest/userguide/data-feed-agreements.html).
    license_arn: ?[]const u8 = null,

    /// The quantity of usage consumed by the customer for the given dimension and
    /// time.
    /// Defaults to `0` if not specified.
    quantity: ?i32 = null,

    /// Timestamp, in UTC, for which the usage is being reported.
    ///
    /// Your application can meter usage for up to six hours in the past. Make sure
    /// the
    /// `timestamp` value is not before the start of the software usage.
    timestamp: i64,

    /// The set of `UsageAllocations` to submit. The sum of all
    /// `UsageAllocation` quantities must equal the Quantity of the
    /// `UsageRecord`.
    usage_allocations: ?[]const UsageAllocation = null,

    pub const json_field_names = .{
        .customer_aws_account_id = "CustomerAWSAccountId",
        .customer_identifier = "CustomerIdentifier",
        .dimension = "Dimension",
        .license_arn = "LicenseArn",
        .quantity = "Quantity",
        .timestamp = "Timestamp",
        .usage_allocations = "UsageAllocations",
    };
};
