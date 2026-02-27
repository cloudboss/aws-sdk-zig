const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Detaches the specified policy from the specified directory inside a
/// BatchWrite operation. For more information, see DetachPolicy and
/// BatchWriteRequest$Operations.
pub const BatchDetachPolicy = struct {
    /// Reference that identifies the object whose policy object will be detached.
    object_reference: ObjectReference,

    /// Reference that identifies the policy object.
    policy_reference: ObjectReference,

    pub const json_field_names = .{
        .object_reference = "ObjectReference",
        .policy_reference = "PolicyReference",
    };
};
