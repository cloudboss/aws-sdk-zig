/// A response that includes successful and failed event results.
pub const AuditEventResultEntry = struct {
    /// The event ID assigned by CloudTrail.
    event_id: []const u8,

    /// The original event ID from the source event.
    id: []const u8,

    pub const json_field_names = .{
        .event_id = "eventID",
        .id = "id",
    };
};
