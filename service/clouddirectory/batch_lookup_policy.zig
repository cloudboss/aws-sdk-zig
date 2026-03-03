const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Lists all policies from the root of the Directory to the object specified
/// inside a BatchRead operation. For more information, see LookupPolicy and
/// BatchReadRequest$Operations.
pub const BatchLookupPolicy = struct {
    /// The maximum number of results to retrieve.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Reference that identifies the object whose policies will be looked up.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};
