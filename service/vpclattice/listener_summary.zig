const ListenerProtocol = @import("listener_protocol.zig").ListenerProtocol;

/// Summary information about a listener.
pub const ListenerSummary = struct {
    /// The Amazon Resource Name (ARN) of the listener.
    arn: ?[]const u8,

    /// The date and time that the listener was created, in ISO-8601 format.
    created_at: ?i64,

    /// The ID of the listener.
    id: ?[]const u8,

    /// The date and time that the listener was last updated, in ISO-8601 format.
    last_updated_at: ?i64,

    /// The name of the listener.
    name: ?[]const u8,

    /// The listener port.
    port: ?i32,

    /// The listener protocol.
    protocol: ?ListenerProtocol,

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
