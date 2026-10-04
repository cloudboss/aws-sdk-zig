const AggregationStatusEnum = @import("aggregation_status_enum.zig").AggregationStatusEnum;
const HealthCheckPathResponseObject = @import("health_check_path_response_object.zig").HealthCheckPathResponseObject;
const IpScopeEnum = @import("ip_scope_enum.zig").IpScopeEnum;
const IpVersionEnum = @import("ip_version_enum.zig").IpVersionEnum;
const NetworkProtocolEnum = @import("network_protocol_enum.zig").NetworkProtocolEnum;
const Tag = @import("tag.zig").Tag;
const CustomTagKeyValueResponsePair = @import("custom_tag_key_value_response_pair.zig").CustomTagKeyValueResponsePair;

/// Describes an application status check.
pub const ApplicationStatusCheckResponseObject = struct {
    /// The aggregation setting for the application status check. When set to
    /// `included`, the result of this check contributes to the instance-level
    /// application status. When set to `excluded`, the check runs independently and
    /// does not affect the instance-level status.
    aggregation: ?AggregationStatusEnum = null,

    /// The ID of the application status check.
    application_status_check_id: ?[]const u8 = null,

    /// The date and time when the application status check was created.
    creation_time: ?i64 = null,

    /// The date and time when the application status check was deleted.
    deletion_time: ?i64 = null,

    /// The index of the network device used for the health check. The value is
    /// greater than or equal to 0.
    device_index: ?i32 = null,

    /// The number of consecutive failed health checks before the application status
    /// is considered impaired. The value must be greater than 0.
    failure_threshold: ?i32 = null,

    /// The health check paths for the application status check.
    health_check_paths: ?[]const HealthCheckPathResponseObject = null,

    /// The number of seconds to wait before starting health checks after an
    /// instance is launched. Valid values: 1 to 600.
    initialization_grace_period_seconds: ?i32 = null,

    /// The interval, in seconds, between health checks. Valid value: 60.
    interval: ?i32 = null,

    /// The IP scope used for the health check.
    ip_scope: ?IpScopeEnum = null,

    /// The IP version used for the health check.
    ip_version: ?IpVersionEnum = null,

    /// The date and time when the application status check was last updated.
    last_updated_at: ?i64 = null,

    /// The date and time when the application status check was last modified.
    modify_time: ?i64 = null,

    /// The URL path used for the health check HTTP request.
    path: ?[]const u8 = null,

    /// The port used for the health check.
    port: ?i32 = null,

    /// The protocol used for the health check.
    protocol: ?NetworkProtocolEnum = null,

    /// The comma-separated list of individual HTTP status codes or ranges that
    /// indicate a successful health check response.
    status_code_matcher: ?[]const u8 = null,

    /// The number of consecutive successful health checks before the application
    /// status is considered healthy. The value must be greater than 0.
    success_threshold: ?i32 = null,

    /// The tags assigned to the application status check.
    tags: ?[]const Tag = null,

    /// The
    /// [tags](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html)
    /// associated with the application status check. Instances with these tags are
    /// automatically monitored by this check.
    target_tag_associations: ?[]const CustomTagKeyValueResponsePair = null,

    /// The amount of time, in seconds, to wait for a health check response. Valid
    /// values: 1 to 30.
    timeout: ?i32 = null,
};
