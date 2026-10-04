const DeletionMode = @import("deletion_mode.zig").DeletionMode;

pub const DeleteResourcePolicyRequest = struct {
    /// Specifies the intended outcome of the operation. Applies only to the
    /// `Document`
    /// resource type. The operation ignores this parameter for other resource
    /// types. Optional. Defaults
    /// to `RemoveSharing`.
    ///
    /// * `RemoveSharing` – Deletes the resource policy and removes sharing of the
    /// document.
    ///
    /// * `RollbackMigration` – Reverts the document to Custom sharing, preserving
    /// existing consumer access, instead of removing the policy.
    deletion_mode: ?DeletionMode = null,

    /// ID of the current policy version. The hash helps to prevent multiple calls
    /// from attempting
    /// to overwrite a policy.
    policy_hash: []const u8,

    /// The policy ID.
    policy_id: []const u8,

    /// Amazon Resource Name (ARN) of the resource to which the policies are
    /// attached.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .deletion_mode = "DeletionMode",
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
        .resource_arn = "ResourceArn",
    };
};
