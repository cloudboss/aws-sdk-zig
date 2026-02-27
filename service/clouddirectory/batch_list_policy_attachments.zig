const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Returns all of the `ObjectIdentifiers` to which a given policy is attached
/// inside a BatchRead operation. For more information, see
/// ListPolicyAttachments and BatchReadRequest$Operations.
pub const BatchListPolicyAttachments = struct {
    /// The maximum number of results to retrieve.
    max_results: ?i32,

    /// The pagination token.
    next_token: ?[]const u8,

    /// The reference that identifies the policy object.
    policy_reference: ObjectReference,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .policy_reference = "PolicyReference",
    };
};
