const HttpUrlDestinationProperties = @import("http_url_destination_properties.zig").HttpUrlDestinationProperties;
const TopicRuleDestinationStatus = @import("topic_rule_destination_status.zig").TopicRuleDestinationStatus;
const VpcDestinationProperties = @import("vpc_destination_properties.zig").VpcDestinationProperties;

/// A topic rule destination.
pub const TopicRuleDestination = struct {
    /// The topic rule destination URL.
    arn: ?[]const u8 = null,

    /// The date and time when the topic rule destination was created.
    created_at: ?i64 = null,

    /// Properties of the HTTP URL.
    http_url_properties: ?HttpUrlDestinationProperties = null,

    /// The date and time when the topic rule destination was last updated.
    last_updated_at: ?i64 = null,

    /// The status of the topic rule destination. Valid values are:
    ///
    /// **IN_PROGRESS**
    ///
    /// A topic rule destination was created but has not been confirmed. You can set
    /// `status` to `IN_PROGRESS` by calling
    /// `UpdateTopicRuleDestination`. Calling
    /// `UpdateTopicRuleDestination` causes a new confirmation challenge to
    /// be sent to your confirmation endpoint.
    ///
    /// **ENABLED**
    ///
    /// Confirmation was completed, and traffic to this destination is allowed. You
    /// can
    /// set `status` to `DISABLED` by calling
    /// `UpdateTopicRuleDestination`.
    ///
    /// **DISABLED**
    ///
    /// Confirmation was completed, and traffic to this destination is not allowed.
    /// You
    /// can set `status` to `ENABLED` by calling
    /// `UpdateTopicRuleDestination`.
    ///
    /// **ERROR**
    ///
    /// Confirmation could not be completed, for example if the confirmation timed
    /// out.
    /// You can call `GetTopicRuleDestination` for details about the error. You
    /// can set `status` to `IN_PROGRESS` by calling
    /// `UpdateTopicRuleDestination`. Calling
    /// `UpdateTopicRuleDestination` causes a new confirmation challenge to
    /// be sent to your confirmation endpoint.
    status: ?TopicRuleDestinationStatus = null,

    /// Additional details or reason why the topic rule destination is in the
    /// current
    /// status.
    status_reason: ?[]const u8 = null,

    /// Properties of the virtual private cloud (VPC) connection.
    vpc_properties: ?VpcDestinationProperties = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .http_url_properties = "httpUrlProperties",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
        .status_reason = "statusReason",
        .vpc_properties = "vpcProperties",
    };
};
