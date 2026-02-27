const UsageAmount = @import("usage_amount.zig").UsageAmount;
const HistoricalUsageEntity = @import("historical_usage_entity.zig").HistoricalUsageEntity;

/// Represents an entry in a batch operation to create bill scenario usage
/// modifications.
pub const BatchCreateBillScenarioUsageModificationEntry = struct {
    /// The amount of usage you want to create for the service use you are modeling.
    amounts: ?[]const UsageAmount,

    /// The Availability Zone that this usage line uses.
    availability_zone: ?[]const u8,

    /// An optional group identifier for the usage modification.
    group: ?[]const u8,

    /// Historical usage data associated with this modification, if available.
    historical_usage: ?HistoricalUsageEntity,

    /// A unique identifier for this entry in the batch operation. This can be any
    /// valid string. This key is useful to identify errors associated with any
    /// usage entry as any error is returned with this key.
    key: []const u8,

    /// The specific operation associated with this usage modification. Describes
    /// the specific Amazon Web Services operation that this usage line models. For
    /// example, `RunInstances` indicates the operation of an Amazon EC2 instance.
    operation: []const u8,

    /// The Amazon Web Services service code for this usage modification. This
    /// identifies the specific Amazon Web Services service to the customer as a
    /// unique short abbreviation. For example, `AmazonEC2` and `AWSKMS`.
    service_code: []const u8,

    /// The Amazon Web Services account ID to which this usage will be applied to.
    usage_account_id: []const u8,

    /// Describes the usage details of the usage line item.
    usage_type: []const u8,

    pub const json_field_names = .{
        .amounts = "amounts",
        .availability_zone = "availabilityZone",
        .group = "group",
        .historical_usage = "historicalUsage",
        .key = "key",
        .operation = "operation",
        .service_code = "serviceCode",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
