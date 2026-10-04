const TargetCapacityType = @import("target_capacity_type.zig").TargetCapacityType;

/// Use this structure to specify the capacity types that Amazon EC2 Auto
/// Scaling prioritizes when it
/// launches instances.
pub const DistributionSegment = struct {
    /// The capacity types to prioritize, in order. Amazon EC2 Auto Scaling attempts
    /// to launch instances in
    /// the priority order of the capacity types, and within each capacity type, in
    /// the order of
    /// instance types listed in your launch template `Overrides`.
    ///
    /// The following lists the valid values:
    ///
    /// **on-demand-capacity-reservation**
    ///
    /// On-Demand Capacity Reservations.
    ///
    /// **capacity-block**
    ///
    /// Capacity Blocks.
    ///
    /// **interruptible-capacity-reservation**
    ///
    /// Interruptible Capacity Reservations.
    ///
    /// **on-demand**
    ///
    /// On-Demand capacity. Include this value to allow the group to fall back to
    /// On-Demand capacity when the preceding capacity types are unavailable.
    target_capacity_types: ?[]const TargetCapacityType = null,
};
