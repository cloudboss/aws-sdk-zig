const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;
const ContainerProperties = @import("container_properties.zig").ContainerProperties;
const EcsProperties = @import("ecs_properties.zig").EcsProperties;
const EksProperties = @import("eks_properties.zig").EksProperties;

/// This is an object that represents the properties of the node range for a
/// multi-node parallel
/// job.
pub const NodeRangeProperty = struct {
    /// Contains a list of consumable resources required by a job.
    consumable_resource_properties: ?ConsumableResourceProperties,

    /// The container details for the node range.
    container: ?ContainerProperties,

    /// This is an object that represents the properties of the node range for a
    /// multi-node parallel
    /// job.
    ecs_properties: ?EcsProperties,

    /// This is an object that represents the properties of the node range for a
    /// multi-node parallel job.
    eks_properties: ?EksProperties,

    /// The instance types of the underlying host infrastructure of a multi-node
    /// parallel
    /// job.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources.
    ///
    /// In addition, this list object is currently limited to one element.
    instance_types: ?[]const []const u8,

    /// The range of nodes, using node index values. A range of `0:3` indicates
    /// nodes
    /// with index values of `0` through `3`. If the starting range value is
    /// omitted (`:n`), then `0` is used to start the range. If the ending range
    /// value is omitted (`n:`), then the highest possible node index is used to end
    /// the
    /// range. Your accumulative node ranges must account for all nodes (`0:n`). You
    /// can nest
    /// node ranges (for example, `0:10` and `4:5`). In this case, the
    /// `4:5` range properties override the `0:10` properties.
    target_nodes: []const u8,

    pub const json_field_names = .{
        .consumable_resource_properties = "consumableResourceProperties",
        .container = "container",
        .ecs_properties = "ecsProperties",
        .eks_properties = "eksProperties",
        .instance_types = "instanceTypes",
        .target_nodes = "targetNodes",
    };
};
