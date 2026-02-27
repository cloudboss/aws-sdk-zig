const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Lists indices attached to an object inside a BatchRead operation. For more
/// information, see ListAttachedIndices and BatchReadRequest$Operations.
pub const BatchListAttachedIndices = struct {
    /// The maximum number of results to retrieve.
    max_results: ?i32,

    /// The pagination token.
    next_token: ?[]const u8,

    /// A reference to the object that has indices attached.
    target_reference: ObjectReference,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .target_reference = "TargetReference",
    };
};
