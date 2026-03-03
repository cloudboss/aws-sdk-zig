/// A structure describing the source of an action.
pub const ActionSource = struct {
    /// The ID of the source.
    source_id: ?[]const u8 = null,

    /// The type of the source.
    source_type: ?[]const u8 = null,

    /// The URI of the source.
    source_uri: []const u8,

    pub const json_field_names = .{
        .source_id = "SourceId",
        .source_type = "SourceType",
        .source_uri = "SourceUri",
    };
};
