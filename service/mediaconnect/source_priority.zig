/// The priority you want to assign to a source. You can have a primary stream
/// and a backup stream or two equally prioritized streams.
pub const SourcePriority = struct {
    /// The name of the source you choose as the primary source for this flow.
    primary_source: ?[]const u8 = null,

    pub const json_field_names = .{
        .primary_source = "PrimarySource",
    };
};
