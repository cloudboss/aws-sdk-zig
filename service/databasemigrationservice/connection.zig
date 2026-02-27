/// Status of the connection between an endpoint and a replication instance,
/// including
/// Amazon Resource Names (ARNs) and the last error message issued.
pub const Connection = struct {
    /// The ARN string that uniquely identifies the endpoint.
    endpoint_arn: ?[]const u8,

    /// The identifier of the endpoint. Identifiers must begin with a letter and
    /// must contain
    /// only ASCII letters, digits, and hyphens. They can't end with a hyphen or
    /// contain two
    /// consecutive hyphens.
    endpoint_identifier: ?[]const u8,

    /// The error message when the connection last failed.
    last_failure_message: ?[]const u8,

    /// The ARN of the replication instance.
    replication_instance_arn: ?[]const u8,

    /// The replication instance identifier. This parameter is stored as a lowercase
    /// string.
    replication_instance_identifier: ?[]const u8,

    /// The connection status. This parameter can return one of the following
    /// values:
    ///
    /// * `"successful"`
    ///
    /// * `"testing"`
    ///
    /// * `"failed"`
    ///
    /// * `"deleting"`
    status: ?[]const u8,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
        .endpoint_identifier = "EndpointIdentifier",
        .last_failure_message = "LastFailureMessage",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .status = "Status",
    };
};
