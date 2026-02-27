const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Detaches the specified object from the specified index inside a BatchRead
/// operation. For more information, see DetachFromIndex and
/// BatchReadRequest$Operations.
pub const BatchDetachFromIndex = struct {
    /// A reference to the index object.
    index_reference: ObjectReference,

    /// A reference to the object being detached from the index.
    target_reference: ObjectReference,

    pub const json_field_names = .{
        .index_reference = "IndexReference",
        .target_reference = "TargetReference",
    };
};
