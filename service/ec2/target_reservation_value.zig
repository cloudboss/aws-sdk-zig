const ReservationValue = @import("reservation_value.zig").ReservationValue;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;

/// The total value of the new Convertible Reserved Instances.
pub const TargetReservationValue = struct {
    /// The total value of the Convertible Reserved Instances that make up the
    /// exchange. This is
    /// the sum of the list value, remaining upfront price, and additional upfront
    /// cost of the
    /// exchange.
    reservation_value: ?ReservationValue,

    /// The configuration of the Convertible Reserved Instances that make up the
    /// exchange.
    target_configuration: ?TargetConfiguration,
};
