const OnDemandResizingSpecification = @import("on_demand_resizing_specification.zig").OnDemandResizingSpecification;
const SpotResizingSpecification = @import("spot_resizing_specification.zig").SpotResizingSpecification;

/// The resize specification for On-Demand and Spot Instances in the fleet.
pub const InstanceFleetResizingSpecifications = struct {
    /// The resize specification for On-Demand Instances in the instance fleet,
    /// which contains
    /// the allocation strategy, capacity reservation options, and the resize
    /// timeout period.
    on_demand_resize_specification: ?OnDemandResizingSpecification = null,

    /// The resize specification for Spot Instances in the instance fleet, which
    /// contains the
    /// allocation strategy and the resize timeout period.
    spot_resize_specification: ?SpotResizingSpecification = null,

    pub const json_field_names = .{
        .on_demand_resize_specification = "OnDemandResizeSpecification",
        .spot_resize_specification = "SpotResizeSpecification",
    };
};
