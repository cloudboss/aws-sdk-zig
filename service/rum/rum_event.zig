/// A structure that contains the information for one performance event that RUM
/// collects from a user session with your application.
pub const RumEvent = struct {
    /// A string containing details about the event.
    details: []const u8,

    /// A unique ID for this event.
    id: []const u8,

    /// Metadata about this event, which contains a JSON serialization of the
    /// identity of the user for this session. The user information comes from
    /// information such as the HTTP user-agent request header and document
    /// interface.
    metadata: ?[]const u8,

    /// The exact time that this event occurred.
    timestamp: i64,

    /// The JSON schema that denotes the type of event this is, such as a page load
    /// or a new session.
    type: []const u8,

    pub const json_field_names = .{
        .details = "details",
        .id = "id",
        .metadata = "metadata",
        .timestamp = "timestamp",
        .type = "type",
    };
};
