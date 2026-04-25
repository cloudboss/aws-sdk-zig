const InferenceComponentAvailabilityZoneBalance = @import("inference_component_availability_zone_balance.zig").InferenceComponentAvailabilityZoneBalance;
const InferenceComponentPlacementStrategy = @import("inference_component_placement_strategy.zig").InferenceComponentPlacementStrategy;

/// The scheduling configuration that determines how inference component copies
/// are placed across available instances when copies are added or removed.
pub const InferenceComponentSchedulingConfig = struct {
    /// Configuration for balancing inference component copies across Availability
    /// Zones.
    availability_zone_balance: ?InferenceComponentAvailabilityZoneBalance = null,

    /// The strategy for placing inference component copies across available
    /// instances. If you also set `AvailabilityZoneBalance`, this strategy applies
    /// to placement within each Availability Zone.
    ///
    /// **SPREAD**
    ///
    /// Distributes copies evenly across available instances for better resilience.
    ///
    /// **BINPACK**
    ///
    /// Packs copies onto fewer instances to optimize resource utilization.
    placement_strategy: InferenceComponentPlacementStrategy,

    pub const json_field_names = .{
        .availability_zone_balance = "AvailabilityZoneBalance",
        .placement_strategy = "PlacementStrategy",
    };
};
