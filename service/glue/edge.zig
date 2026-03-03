/// An edge represents a directed connection between two Glue components that
/// are part of the workflow the
/// edge belongs to.
pub const Edge = struct {
    /// The unique of the node within the workflow where the edge ends.
    destination_id: ?[]const u8 = null,

    /// The unique of the node within the workflow where the edge starts.
    source_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_id = "DestinationId",
        .source_id = "SourceId",
    };
};
