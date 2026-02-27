pub const DeleteConnectionMessage = struct {
    /// The Amazon Resource Name (ARN) string that uniquely identifies the endpoint.
    endpoint_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: []const u8,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
        .replication_instance_arn = "ReplicationInstanceArn",
    };
};
