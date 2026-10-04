const SyslogSourceType = @import("syslog_source_type.zig").SyslogSourceType;

/// Contains information about a syslog configuration associated with a log
/// group.
pub const SyslogConfiguration = struct {
    /// The time when the syslog configuration was created, expressed as the number
    /// of
    /// milliseconds after `Jan 1, 1970 00:00:00 UTC`.
    created_at: ?i64 = null,

    /// The ARN of the log group associated with this syslog configuration.
    log_group_arn: ?[]const u8 = null,

    /// The source type for the syslog configuration.
    source_type: ?SyslogSourceType = null,

    /// The ID of the VPC endpoint used for syslog ingestion.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .log_group_arn = "logGroupArn",
        .source_type = "sourceType",
        .vpc_endpoint_id = "vpcEndpointId",
    };
};
