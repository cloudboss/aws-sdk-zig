/// A structure for a partition index.
pub const PartitionIndex = struct {
    /// The name of the partition index.
    index_name: []const u8,

    /// The keys for the partition index.
    keys: []const []const u8,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .keys = "Keys",
    };
};
