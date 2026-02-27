const AutoScalingGroupProvider = @import("auto_scaling_group_provider.zig").AutoScalingGroupProvider;
const ManagedInstancesProvider = @import("managed_instances_provider.zig").ManagedInstancesProvider;
const CapacityProviderStatus = @import("capacity_provider_status.zig").CapacityProviderStatus;
const Tag = @import("tag.zig").Tag;
const CapacityProviderType = @import("capacity_provider_type.zig").CapacityProviderType;
const CapacityProviderUpdateStatus = @import("capacity_provider_update_status.zig").CapacityProviderUpdateStatus;

/// The details for a capacity provider.
pub const CapacityProvider = struct {
    /// The Auto Scaling group settings for the capacity provider.
    auto_scaling_group_provider: ?AutoScalingGroupProvider,

    /// The Amazon Resource Name (ARN) that identifies the capacity provider.
    capacity_provider_arn: ?[]const u8,

    /// The cluster that this capacity provider is associated with. Managed
    /// instances capacity
    /// providers are cluster-scoped, meaning they can only be used within their
    /// associated
    /// cluster.
    ///
    /// This is required for Managed instances.
    cluster: ?[]const u8,

    /// The configuration for the Amazon ECS Managed Instances provider. This
    /// includes the
    /// infrastructure role, the launch template configuration, and tag propagation
    /// settings.
    managed_instances_provider: ?ManagedInstancesProvider,

    /// The name of the capacity provider.
    name: ?[]const u8,

    /// The current status of the capacity provider. Only capacity providers in an
    /// `ACTIVE` state can be used in a cluster. When a capacity provider is
    /// successfully deleted, it has an `INACTIVE` status.
    status: ?CapacityProviderStatus,

    /// The metadata that you apply to the capacity provider to help you categorize
    /// and
    /// organize it. Each tag consists of a key and an optional value. You define
    /// both.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only
    /// one value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8
    ///
    /// * If your tagging schema is used across multiple services and resources,
    /// remember that other services may have restrictions on allowed characters.
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in
    /// UTF-8, and the following characters: + - = . _ : / @.
    ///
    /// * Tag keys and values are case-sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase
    /// combination of such as a prefix for either keys or values as it is reserved
    /// for
    /// Amazon Web
    /// Services use. You cannot edit or delete tag keys or values with
    /// this prefix. Tags with this prefix do not count against your tags per
    /// resource
    /// limit.
    tags: ?[]const Tag,

    /// The type of capacity provider. For Amazon ECS Managed Instances, this value
    /// is
    /// `MANAGED_INSTANCES`, indicating that Amazon ECS manages the underlying
    /// Amazon EC2 instances on your behalf.
    type: ?CapacityProviderType,

    /// The update status of the capacity provider. The following are the possible
    /// states that
    /// is returned.
    ///
    /// **DELETE_IN_PROGRESS**
    ///
    /// The capacity provider is in the process of being deleted.
    ///
    /// **DELETE_COMPLETE**
    ///
    /// The capacity provider was successfully deleted and has an
    /// `INACTIVE` status.
    ///
    /// **DELETE_FAILED**
    ///
    /// The capacity provider can't be deleted. The update status reason provides
    /// further details about why the delete failed.
    update_status: ?CapacityProviderUpdateStatus,

    /// The update status reason. This provides further details about the update
    /// status for
    /// the capacity provider.
    update_status_reason: ?[]const u8,

    pub const json_field_names = .{
        .auto_scaling_group_provider = "autoScalingGroupProvider",
        .capacity_provider_arn = "capacityProviderArn",
        .cluster = "cluster",
        .managed_instances_provider = "managedInstancesProvider",
        .name = "name",
        .status = "status",
        .tags = "tags",
        .type = "type",
        .update_status = "updateStatus",
        .update_status_reason = "updateStatusReason",
    };
};
