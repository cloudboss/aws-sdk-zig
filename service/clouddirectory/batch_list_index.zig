const ObjectReference = @import("object_reference.zig").ObjectReference;
const ObjectAttributeRange = @import("object_attribute_range.zig").ObjectAttributeRange;

/// Lists objects attached to the specified index inside a BatchRead operation.
/// For more information, see ListIndex and BatchReadRequest$Operations.
pub const BatchListIndex = struct {
    /// The reference to the index to list.
    index_reference: ObjectReference,

    /// The maximum number of results to retrieve.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Specifies the ranges of indexed values that you want to query.
    ranges_on_indexed_values: ?[]const ObjectAttributeRange = null,

    pub const json_field_names = .{
        .index_reference = "IndexReference",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .ranges_on_indexed_values = "RangesOnIndexedValues",
    };
};
