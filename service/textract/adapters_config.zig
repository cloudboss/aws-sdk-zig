const Adapter = @import("adapter.zig").Adapter;

/// Contains information about adapters used when analyzing a document,
/// with each adapter specified using an AdapterId and version
pub const AdaptersConfig = struct {
    /// A list of adapters to be used when analyzing the specified document.
    adapters: []const Adapter,

    pub const json_field_names = .{
        .adapters = "Adapters",
    };
};
