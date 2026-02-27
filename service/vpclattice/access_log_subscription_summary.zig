const ServiceNetworkLogType = @import("service_network_log_type.zig").ServiceNetworkLogType;

/// Summary information about an access log subscription.
pub const AccessLogSubscriptionSummary = struct {
    /// The Amazon Resource Name (ARN) of the access log subscription
    arn: []const u8,

    /// The date and time that the access log subscription was created, in ISO-8601
    /// format.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the destination.
    destination_arn: []const u8,

    /// The ID of the access log subscription.
    id: []const u8,

    /// The date and time that the access log subscription was last updated, in
    /// ISO-8601 format.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the service or service network.
    resource_arn: []const u8,

    /// The ID of the service or service network.
    resource_id: []const u8,

    /// Log type of the service network.
    service_network_log_type: ?ServiceNetworkLogType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .destination_arn = "destinationArn",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .service_network_log_type = "serviceNetworkLogType",
    };
};
