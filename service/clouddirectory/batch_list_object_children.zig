const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Represents the output of a ListObjectChildren operation.
pub const BatchListObjectChildren = struct {
    /// Maximum number of items to be retrieved in a single call. This is an
    /// approximate
    /// number.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Reference of the object for which child objects are being listed.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};
