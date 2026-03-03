const aws = @import("aws");

const TimePeriod = @import("time_period.zig").TimePeriod;

/// Contains summary information about a spending limit, including current
/// spending status and configuration details.
pub const SpendingLimitSummary = struct {
    /// The date and time when the spending limit was created, in epoch seconds.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the quantum device associated with this
    /// spending limit.
    device_arn: []const u8,

    /// The amount currently queued for spending on the device, in USD.
    queued_spend: []const u8,

    /// The maximum spending amount allowed for the device during the specified time
    /// period, in USD.
    spending_limit: []const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies the spending limit.
    spending_limit_arn: []const u8,

    /// The tags associated with the spending limit. Each tag consists of a key and
    /// an optional value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time period during which the spending limit is active.
    time_period: TimePeriod,

    /// The total amount spent on the device so far during the current time period,
    /// in USD.
    total_spend: []const u8,

    /// The date and time when the spending limit was last modified, in epoch
    /// seconds.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .device_arn = "deviceArn",
        .queued_spend = "queuedSpend",
        .spending_limit = "spendingLimit",
        .spending_limit_arn = "spendingLimitArn",
        .tags = "tags",
        .time_period = "timePeriod",
        .total_spend = "totalSpend",
        .updated_at = "updatedAt",
    };
};
