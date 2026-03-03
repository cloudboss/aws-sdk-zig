const ConnectionState = @import("connection_state.zig").ConnectionState;

pub const CreateConnectionResponse = struct {
    /// The ARN of the connection that was created by the request.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection that was created by the request.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// A time stamp for the time that the connection was last updated.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};
