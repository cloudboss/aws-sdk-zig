const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Attaches a policy object to a regular object inside a BatchRead
/// operation. For more information, see AttachPolicy and
/// BatchReadRequest$Operations.
pub const BatchAttachPolicy = struct {
    /// The reference that identifies the object to which the policy will be
    /// attached.
    object_reference: ObjectReference,

    /// The reference that is associated with the policy object.
    policy_reference: ObjectReference,

    pub const json_field_names = .{
        .object_reference = "ObjectReference",
        .policy_reference = "PolicyReference",
    };
};
