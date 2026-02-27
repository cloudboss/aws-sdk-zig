const ObjectAttributeUpdate = @import("object_attribute_update.zig").ObjectAttributeUpdate;
const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Represents the output of a `BatchUpdate` operation.
pub const BatchUpdateObjectAttributes = struct {
    /// Attributes update structure.
    attribute_updates: []const ObjectAttributeUpdate,

    /// Reference that identifies the object.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .attribute_updates = "AttributeUpdates",
        .object_reference = "ObjectReference",
    };
};
