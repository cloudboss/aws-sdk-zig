const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Retrieves metadata about an object inside a BatchRead operation. For more
/// information, see GetObjectInformation and BatchReadRequest$Operations.
pub const BatchGetObjectInformation = struct {
    /// A reference to the object.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .object_reference = "ObjectReference",
    };
};
