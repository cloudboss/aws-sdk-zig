/// The configuration of an event that the application publishes.
pub const Publication = struct {
    /// The description of the publication.
    description: ?[]const u8,

    /// The name of the publication.
    event: []const u8,

    /// The JSON schema of the publication event.
    schema: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .event = "Event",
        .schema = "Schema",
    };
};
