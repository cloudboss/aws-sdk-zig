const ConnectionAuthorizationType = @import("connection_authorization_type.zig").ConnectionAuthorizationType;
const ConnectionState = @import("connection_state.zig").ConnectionState;

/// Contains information about a connection.
pub const Connection = struct {
    /// The authorization type specified for the connection.
    ///
    /// OAUTH tokens are refreshed when a 401 or 407 response is returned.
    authorization_type: ?ConnectionAuthorizationType = null,

    /// The ARN of the connection.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// A time stamp for the time that the connection was last authorized.
    last_authorized_time: ?i64 = null,

    /// A time stamp for the time that the connection was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the connection.
    name: ?[]const u8 = null,

    /// The reason that the connection is in the connection state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_type = "AuthorizationType",
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .last_authorized_time = "LastAuthorizedTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .state_reason = "StateReason",
    };
};
