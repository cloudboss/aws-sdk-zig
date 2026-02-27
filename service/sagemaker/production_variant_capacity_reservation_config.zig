const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;

/// Settings for the capacity reservation for the compute instances that
/// SageMaker AI reserves for an endpoint.
pub const ProductionVariantCapacityReservationConfig = struct {
    /// Options that you can choose for the capacity reservation. SageMaker AI
    /// supports the following options:
    ///
    /// **capacity-reservations-only**
    ///
    /// SageMaker AI launches instances only into an ML capacity reservation. If no
    /// capacity is available, the instances fail to launch.
    capacity_reservation_preference: ?CapacityReservationPreference,

    /// The Amazon Resource Name (ARN) that uniquely identifies the ML capacity
    /// reservation that SageMaker AI applies when it deploys the endpoint.
    ml_reservation_arn: ?[]const u8,

    pub const json_field_names = .{
        .capacity_reservation_preference = "CapacityReservationPreference",
        .ml_reservation_arn = "MlReservationArn",
    };
};
