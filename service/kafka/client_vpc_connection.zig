const VpcConnectionState = @import("vpc_connection_state.zig").VpcConnectionState;

/// The client VPC connection object.
pub const ClientVpcConnection = struct {
    /// Information about the auth scheme of Vpc Connection.
    authentication: ?[]const u8 = null,

    /// Creation time of the Vpc Connection.
    creation_time: ?i64 = null,

    /// The Owner of the Vpc Connection.
    owner: ?[]const u8 = null,

    /// State of the Vpc Connection.
    state: ?VpcConnectionState = null,

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
