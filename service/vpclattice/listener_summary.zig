const ListenerProtocol = @import("listener_protocol.zig").ListenerProtocol;

/// Summary information about a listener.
pub const ListenerSummary = struct {
    /// The Amazon Resource Name (ARN) of the listener.
    arn: ?[]const u8 = null,

    /// The date and time that the listener was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The ID of the listener.
    id: ?[]const u8 = null,

    /// The date and time that the listener was last updated, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the listener.
    name: ?[]const u8 = null,

    /// The listener port.
    port: ?i32 = null,

    /// The listener protocol.
    protocol: ?ListenerProtocol = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .port = "port",
        .protocol = "protocol",
    };
};
