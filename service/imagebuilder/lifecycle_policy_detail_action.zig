const LifecyclePolicyDetailActionIncludeResources = @import("lifecycle_policy_detail_action_include_resources.zig").LifecyclePolicyDetailActionIncludeResources;
const LifecyclePolicyDetailActionType = @import("lifecycle_policy_detail_action_type.zig").LifecyclePolicyDetailActionType;

/// Contains selection criteria for the lifecycle policy.
pub const LifecyclePolicyDetailAction = struct {
    /// Specifies the resources that the lifecycle policy applies to.
    include_resources: ?LifecyclePolicyDetailActionIncludeResources,

    /// Specifies the lifecycle action to take.
    type: LifecyclePolicyDetailActionType,

    pub const json_field_names = .{
        .include_resources = "includeResources",
        .type = "type",
    };
};
