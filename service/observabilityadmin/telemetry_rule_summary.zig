const ResourceType = @import("resource_type.zig").ResourceType;
const TelemetrySourceType = @import("telemetry_source_type.zig").TelemetrySourceType;
const TelemetryType = @import("telemetry_type.zig").TelemetryType;

/// A summary of a telemetry rule's key properties.
pub const TelemetryRuleSummary = struct {
    /// The timestamp when the telemetry rule was created.
    created_time_stamp: ?i64 = null,

    /// The timestamp when the telemetry rule was last modified.
    last_update_time_stamp: ?i64 = null,

    /// The type of Amazon Web Services resource the rule applies to.
    resource_type: ?ResourceType = null,

    /// The Amazon Resource Name (ARN) of the telemetry rule.
    rule_arn: ?[]const u8 = null,

    /// The name of the telemetry rule.
    rule_name: ?[]const u8 = null,

    /// The types of telemetry sources configured for this rule, such as VPC Flow
    /// Logs or EKS audit logs. TelemetrySourceTypes must be correlated with the
    /// specific resource type.
    telemetry_source_types: ?[]const TelemetrySourceType = null,

    /// The type of telemetry (Logs, Metrics, or Traces) the rule configures.
    telemetry_type: ?TelemetryType = null,

    pub const json_field_names = .{
        .created_time_stamp = "CreatedTimeStamp",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .resource_type = "ResourceType",
        .rule_arn = "RuleArn",
        .rule_name = "RuleName",
        .telemetry_source_types = "TelemetrySourceTypes",
        .telemetry_type = "TelemetryType",
    };
};
