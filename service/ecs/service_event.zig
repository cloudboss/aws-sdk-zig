/// The details for an event that's associated with a service.
pub const ServiceEvent = struct {
    /// The Unix timestamp for the time when the event was triggered.
    created_at: ?i64 = null,

    /// The ID string for the event.
    id: ?[]const u8 = null,

    /// The event message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .id = "id",
        .message = "message",
    };
};
