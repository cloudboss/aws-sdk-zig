const LifecyclePolicyTargetStorageClass = @import("lifecycle_policy_target_storage_class.zig").LifecyclePolicyTargetStorageClass;
const ImageActionType = @import("image_action_type.zig").ImageActionType;

/// The type of action to be taken.
pub const LifecyclePolicyRuleAction = struct {
    /// The target storage class for the action. This is only present when the
    /// `type` is `TRANSITION.`
    target_storage_class: ?LifecyclePolicyTargetStorageClass = null,

    /// The type of action to be taken.
    @"type": ?ImageActionType = null,

    pub const json_field_names = .{
        .target_storage_class = "targetStorageClass",
        .@"type" = "type",
    };
};
