const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Attaches the specified object to the specified index inside a BatchRead
/// operation. For more information, see AttachToIndex and
/// BatchReadRequest$Operations.
pub const BatchAttachToIndex = struct {
    /// A reference to the index that you are attaching the object to.
    index_reference: ObjectReference,

    /// A reference to the object that you are attaching to the index.
    target_reference: ObjectReference,

    pub const json_field_names = .{
        .index_reference = "IndexReference",
        .target_reference = "TargetReference",
    };
};
