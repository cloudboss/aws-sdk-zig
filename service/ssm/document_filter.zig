const DocumentFilterKey = @import("document_filter_key.zig").DocumentFilterKey;

/// This data type is deprecated. Instead, use DocumentKeyValuesFilter.
pub const DocumentFilter = struct {
    /// The name of the filter.
    key: DocumentFilterKey,

    /// The value of the filter.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
