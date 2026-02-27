const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Represents the output of an AttachObject operation.
pub const BatchAttachObject = struct {
    /// The child object reference that is to be attached to the object.
    child_reference: ObjectReference,

    /// The name of the link.
    link_name: []const u8,

    /// The parent object reference.
    parent_reference: ObjectReference,

    pub const json_field_names = .{
        .child_reference = "ChildReference",
        .link_name = "LinkName",
        .parent_reference = "ParentReference",
    };
};
