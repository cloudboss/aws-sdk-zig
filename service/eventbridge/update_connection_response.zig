const ConnectionState = @import("connection_state.zig").ConnectionState;

pub const UpdateConnectionResponse = struct {
    /// The ARN of the connection that was updated.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection that was updated.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// A time stamp for the time that the connection was last authorized.
    last_authorized_time: ?i64 = null,

    /// A time stamp for the time that the connection was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .last_authorized_time = "LastAuthorizedTime",
        .last_modified_time = "LastModifiedTime",
    };
};
