const VpcConnectionState = @import("vpc_connection_state.zig").VpcConnectionState;

/// The VPC connection object.
pub const VpcConnection = struct {
    /// Information about the auth scheme of Vpc Connection.
    authentication: ?[]const u8,

    /// Creation time of the Vpc Connection.
    creation_time: ?i64,

    /// State of the Vpc Connection.
    state: ?VpcConnectionState,

    /// The ARN that identifies the Cluster which the Vpc Connection belongs to.
    target_cluster_arn: []const u8,

    /// The ARN that identifies the Vpc Connection.
    vpc_connection_arn: []const u8,

    /// The vpcId that belongs to the Vpc Connection.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .authentication = "Authentication",
        .creation_time = "CreationTime",
        .state = "State",
        .target_cluster_arn = "TargetClusterArn",
        .vpc_connection_arn = "VpcConnectionArn",
        .vpc_id = "VpcId",
    };
};
