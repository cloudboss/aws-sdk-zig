/// A filter to limit the number of OpsMetadata objects displayed.
pub const OpsMetadataFilter = struct {
    /// A filter key.
    key: []const u8,

    /// A filter value.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
