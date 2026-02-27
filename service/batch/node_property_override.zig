const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;
const ContainerOverrides = @import("container_overrides.zig").ContainerOverrides;
const EcsPropertiesOverride = @import("ecs_properties_override.zig").EcsPropertiesOverride;
const EksPropertiesOverride = @import("eks_properties_override.zig").EksPropertiesOverride;

/// The object that represents any node overrides to a job definition that's
/// used in a
/// [SubmitJob](https://docs.aws.amazon.com/batch/latest/APIReference/API_SubmitJob.html) API
/// operation.
pub const NodePropertyOverride = struct {
    /// An object that contains overrides for the consumable resources of a job.
    consumable_resource_properties_override: ?ConsumableResourceProperties,

    /// The overrides that are sent to a node range.
    container_overrides: ?ContainerOverrides,

    /// An object that contains the properties that you want to replace for the
    /// existing Amazon ECS
    /// resources of a job.
    ecs_properties_override: ?EcsPropertiesOverride,

    /// An object that contains the properties that you want to replace for the
    /// existing Amazon EKS resources of a job.
    eks_properties_override: ?EksPropertiesOverride,

    /// An object that contains the instance types that you want to replace for the
    /// existing
    /// resources of a job.
    instance_types: ?[]const []const u8,

    /// The range of nodes, using node index values, that's used to override. A
    /// range of
    /// `0:3` indicates nodes with index values of `0` through `3`. If
    /// the starting range value is omitted (`:n`), then `0` is used to start the
    /// range. If the ending range value is omitted (`n:`), then the highest
    /// possible node
    /// index is used to end the range.
    target_nodes: []const u8,

    pub const json_field_names = .{
        .consumable_resource_properties_override = "consumableResourcePropertiesOverride",
        .container_overrides = "containerOverrides",
        .ecs_properties_override = "ecsPropertiesOverride",
        .eks_properties_override = "eksPropertiesOverride",
        .instance_types = "instanceTypes",
        .target_nodes = "targetNodes",
    };
};
