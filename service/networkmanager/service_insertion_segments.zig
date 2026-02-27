/// Describes the segments associated with the service insertion action.
pub const ServiceInsertionSegments = struct {
    /// The list of segments associated with the `send-to` action.
    send_to: ?[]const []const u8,

    /// The list of segments associated with the `send-via` action.
    send_via: ?[]const []const u8,

    pub const json_field_names = .{
        .send_to = "SendTo",
        .send_via = "SendVia",
    };
};
