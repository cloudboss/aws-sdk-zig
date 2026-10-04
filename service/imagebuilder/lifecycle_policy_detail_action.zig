const LifecyclePolicyDetailActionIncludeResources = @import("lifecycle_policy_detail_action_include_resources.zig").LifecyclePolicyDetailActionIncludeResources;
const LifecyclePolicyDetailActionType = @import("lifecycle_policy_detail_action_type.zig").LifecyclePolicyDetailActionType;

/// Contains the action configuration for a lifecycle policy rule: the action to
/// take, and which underlying resources the action extends to.
pub const LifecyclePolicyDetailAction = struct {
    /// Specifies which underlying resources the action extends to beyond the Image
    /// Builder
    /// image resource itself: distributed AMIs, their snapshots, or distributed
    /// container images. `DELETE` rules can include all three,
    /// `DEPRECATE` and `DISABLE` rules can include AMIs only,
    /// and you can only include snapshots together with AMIs.
    include_resources: ?LifecyclePolicyDetailActionIncludeResources = null,

    /// Specifies the lifecycle action to take. `DELETE` deletes the
    /// image resource and, with `includeResources`, also removes
    /// distributed AMIs, snapshots, or container images. `DEPRECATE` and
    /// `DISABLE` set the corresponding status on the image resource and,
    /// if `includeResources.amis` is set, on its distributed AMIs.
    @"type": LifecyclePolicyDetailActionType,

    pub const json_field_names = .{
        .include_resources = "includeResources",
        .@"type" = "type",
    };
};
