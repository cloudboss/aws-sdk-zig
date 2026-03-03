const OnDemandCapacityReservationPreference = @import("on_demand_capacity_reservation_preference.zig").OnDemandCapacityReservationPreference;
const OnDemandCapacityReservationUsageStrategy = @import("on_demand_capacity_reservation_usage_strategy.zig").OnDemandCapacityReservationUsageStrategy;

/// Describes the strategy for using unused Capacity Reservations for fulfilling
/// On-Demand
/// capacity.
pub const OnDemandCapacityReservationOptions = struct {
    /// Indicates the instance's Capacity Reservation preferences. Possible
    /// preferences
    /// include:
    ///
    /// * `open` - The instance can run in any open Capacity Reservation that has
    /// matching attributes (instance type, platform, Availability Zone).
    ///
    /// * `none` - The instance avoids running in a Capacity Reservation even if
    /// one is available. The instance runs as an On-Demand Instance.
    capacity_reservation_preference: ?OnDemandCapacityReservationPreference = null,

    /// The ARN of the Capacity Reservation resource group in which to run the
    /// instance.
    capacity_reservation_resource_group_arn: ?[]const u8 = null,

    /// Indicates whether to use unused Capacity Reservations for fulfilling
    /// On-Demand
    /// capacity.
    ///
    /// If you specify `use-capacity-reservations-first`, the fleet uses unused
    /// Capacity Reservations to fulfill On-Demand capacity up to the target
    /// On-Demand capacity. If
    /// multiple instance pools have unused Capacity Reservations, the On-Demand
    /// allocation
    /// strategy (`lowest-price`) is applied. If the number of unused Capacity
    /// Reservations is less than the On-Demand target capacity, the remaining
    /// On-Demand target
    /// capacity is launched according to the On-Demand allocation strategy
    /// (`lowest-price`).
    ///
    /// If you do not specify a value, the fleet fulfills the On-Demand capacity
    /// according to
    /// the chosen On-Demand allocation strategy.
    usage_strategy: ?OnDemandCapacityReservationUsageStrategy = null,

    pub const json_field_names = .{
        .capacity_reservation_preference = "CapacityReservationPreference",
        .capacity_reservation_resource_group_arn = "CapacityReservationResourceGroupArn",
        .usage_strategy = "UsageStrategy",
    };
};
