const MetadataValueType = @import("metadata_value_type.zig").MetadataValueType;

/// A metadata key indexed for filtering.
pub const IndexedKey = struct {
    /// The metadata key name to index.
    key: []const u8,

    /// The data type of the indexed key.
    @"type": MetadataValueType,

    pub const json_field_names = .{
        .key = "key",
        .@"type" = "type",
    };
};
