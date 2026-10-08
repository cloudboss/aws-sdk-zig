/// Reference information linking a task to external systems - for output
/// without validation
pub const ReferenceOutput = struct {
    /// Association identifier of the external system
    association_id: []const u8,

    /// The unique identifier in the external system
    reference_id: []const u8,

    /// URL to access the reference in the external system
    reference_url: []const u8,

    /// The name of the external system
    system: []const u8,

    /// Optional title for the reference
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "associationId",
        .reference_id = "referenceId",
        .reference_url = "referenceUrl",
        .system = "system",
        .title = "title",
    };
};
