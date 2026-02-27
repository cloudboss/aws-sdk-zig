const VpcConnectionState = @import("vpc_connection_state.zig").VpcConnectionState;

/// The client VPC connection object.
pub const ClientVpcConnection = struct {
    /// Information about the auth scheme of Vpc Connection.
    authentication: ?[]const u8,

    /// Creation time of the Vpc Connection.
    creation_time: ?i64,

    /// The Owner of the Vpc Connection.
    owner: ?[]const u8,

    /// State of the Vpc Connection.
    state: ?VpcConnectionState,

    /// The ARN that identifies the Vpc Connection.
    vpc_connection_arn: []const u8,

    pub const json_field_names = .{
        .authentication = "Authentication",
        .creation_time = "CreationTime",
        .owner = "Owner",
        .state = "State",
        .vpc_connection_arn = "VpcConnectionArn",
    };
};
