const RefreshSchemasStatusTypeValue = @import("refresh_schemas_status_type_value.zig").RefreshSchemasStatusTypeValue;

/// Provides information that describes status of a schema at an endpoint
/// specified by the
/// `DescribeRefreshSchemaStatus` operation.
pub const RefreshSchemasStatus = struct {
    /// The Amazon Resource Name (ARN) string that uniquely identifies the endpoint.
    endpoint_arn: ?[]const u8 = null,

    /// The last failure message for the schema.
    last_failure_message: ?[]const u8 = null,

    /// The date the schema was last refreshed.
    last_refresh_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: ?[]const u8 = null,

    /// The status of the schema.
    status: ?RefreshSchemasStatusTypeValue = null,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
        .last_failure_message = "LastFailureMessage",
        .last_refresh_date = "LastRefreshDate",
        .replication_instance_arn = "ReplicationInstanceArn",
        .status = "Status",
    };
};
