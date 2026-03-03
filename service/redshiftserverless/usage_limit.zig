const UsageLimitBreachAction = @import("usage_limit_breach_action.zig").UsageLimitBreachAction;
const UsageLimitPeriod = @import("usage_limit_period.zig").UsageLimitPeriod;
const UsageLimitUsageType = @import("usage_limit_usage_type.zig").UsageLimitUsageType;

/// The usage limit object.
pub const UsageLimit = struct {
    /// The limit amount. If time-based, this amount is in RPUs consumed per hour.
    /// If data-based, this amount is in terabytes (TB). The value must be a
    /// positive number.
    amount: ?i64 = null,

    /// The action that Amazon Redshift Serverless takes when the limit is reached.
    breach_action: ?UsageLimitBreachAction = null,

    /// The time period that the amount applies to. A weekly period begins on
    /// Sunday. The default is monthly.
    period: ?UsageLimitPeriod = null,

    /// The Amazon Resource Name (ARN) that identifies the Amazon Redshift
    /// Serverless resource.
    resource_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource associated with the usage
    /// limit.
    usage_limit_arn: ?[]const u8 = null,

    /// The identifier of the usage limit.
    usage_limit_id: ?[]const u8 = null,

    /// The Amazon Redshift Serverless feature to limit.
    usage_type: ?UsageLimitUsageType = null,

    pub const json_field_names = .{
        .amount = "amount",
        .breach_action = "breachAction",
        .period = "period",
        .resource_arn = "resourceArn",
        .usage_limit_arn = "usageLimitArn",
        .usage_limit_id = "usageLimitId",
        .usage_type = "usageType",
    };
};
