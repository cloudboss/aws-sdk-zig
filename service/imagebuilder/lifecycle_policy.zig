const aws = @import("aws");

const LifecyclePolicyDetail = @import("lifecycle_policy_detail.zig").LifecyclePolicyDetail;
const LifecyclePolicyResourceSelection = @import("lifecycle_policy_resource_selection.zig").LifecyclePolicyResourceSelection;
const LifecyclePolicyResourceType = @import("lifecycle_policy_resource_type.zig").LifecyclePolicyResourceType;
const LifecyclePolicyStatus = @import("lifecycle_policy_status.zig").LifecyclePolicyStatus;

/// The configuration details for a lifecycle policy resource.
pub const LifecyclePolicy = struct {
    /// The Amazon Resource Name (ARN) of the lifecycle policy resource.
    arn: ?[]const u8,

    /// The timestamp when Image Builder created the lifecycle policy resource.
    date_created: ?i64,

    /// The timestamp for the last time Image Builder ran the lifecycle policy.
    date_last_run: ?i64,

    /// The timestamp when Image Builder updated the lifecycle policy resource.
    date_updated: ?i64,

    /// Optional description for the lifecycle policy.
    description: ?[]const u8,

    /// The name or Amazon Resource Name (ARN) of the IAM role that Image Builder
    /// uses to run the lifecycle policy.
    /// This is a custom role that you create.
    execution_role: ?[]const u8,

    /// The name of the lifecycle policy.
    name: ?[]const u8,

    /// The configuration details for a lifecycle policy resource.
    policy_details: ?[]const LifecyclePolicyDetail,

    /// Resource selection criteria used to run the lifecycle policy.
    resource_selection: ?LifecyclePolicyResourceSelection,

    /// The type of resources the lifecycle policy targets.
    resource_type: ?LifecyclePolicyResourceType,

    /// Indicates whether the lifecycle policy resource is enabled.
    status: ?LifecyclePolicyStatus,

    /// To help manage your lifecycle policy resources, you can assign your own
    /// metadata to each resource in the form of tags. Each tag consists of a key
    /// and
    /// an optional value, both of which you define.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .date_last_run = "dateLastRun",
        .date_updated = "dateUpdated",
        .description = "description",
        .execution_role = "executionRole",
        .name = "name",
        .policy_details = "policyDetails",
        .resource_selection = "resourceSelection",
        .resource_type = "resourceType",
        .status = "status",
        .tags = "tags",
    };
};
