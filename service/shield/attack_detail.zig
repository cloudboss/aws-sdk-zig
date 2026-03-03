const SummarizedCounter = @import("summarized_counter.zig").SummarizedCounter;
const AttackProperty = @import("attack_property.zig").AttackProperty;
const Mitigation = @import("mitigation.zig").Mitigation;
const SubResourceSummary = @import("sub_resource_summary.zig").SubResourceSummary;

/// The details of a DDoS attack.
pub const AttackDetail = struct {
    /// List of counters that describe the attack for the specified time period.
    attack_counters: ?[]const SummarizedCounter = null,

    /// The unique identifier (ID) of the attack.
    attack_id: ?[]const u8 = null,

    /// The array of objects that provide details of the Shield event.
    ///
    /// For infrastructure
    /// layer events (L3 and L4 events), you can view metrics for top contributors
    /// in Amazon CloudWatch metrics.
    /// For more information, see [Shield metrics and
    /// alarms](https://docs.aws.amazon.com/waf/latest/developerguide/monitoring-cloudwatch.html#set-ddos-alarms)
    /// in the *WAF Developer Guide*.
    attack_properties: ?[]const AttackProperty = null,

    /// The time the attack ended, in Unix time in seconds.
    end_time: ?i64 = null,

    /// List of mitigation actions taken for the attack.
    mitigations: ?[]const Mitigation = null,

    /// The ARN (Amazon Resource Name) of the resource that was attacked.
    resource_arn: ?[]const u8 = null,

    /// The time the attack started, in Unix time in seconds.
    start_time: ?i64 = null,

    /// If applicable, additional detail about the resource being attacked, for
    /// example, IP address or URL.
    sub_resources: ?[]const SubResourceSummary = null,

    pub const json_field_names = .{
        .attack_counters = "AttackCounters",
        .attack_id = "AttackId",
        .attack_properties = "AttackProperties",
        .end_time = "EndTime",
        .mitigations = "Mitigations",
        .resource_arn = "ResourceArn",
        .start_time = "StartTime",
        .sub_resources = "SubResources",
    };
};
