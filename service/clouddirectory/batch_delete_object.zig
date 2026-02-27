const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Represents the output of a DeleteObject operation.
pub const BatchDeleteObject = struct {
    /// The reference that identifies the object.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .object_reference = "ObjectReference",
    };
};
