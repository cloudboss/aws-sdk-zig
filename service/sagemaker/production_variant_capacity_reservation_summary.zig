const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const Ec2CapacityReservation = @import("ec_2_capacity_reservation.zig").Ec2CapacityReservation;

/// Details about an ML capacity reservation.
pub const ProductionVariantCapacityReservationSummary = struct {
    /// The number of instances that are currently available in the ML capacity
    /// reservation.
    available_instance_count: ?i32,

    /// The option that you chose for the capacity reservation. SageMaker AI
    /// supports the following options:
    ///
    /// **capacity-reservations-only**
    ///
    /// SageMaker AI launches instances only into an ML capacity reservation. If no
    /// capacity is available, the instances fail to launch.
    capacity_reservation_preference: ?CapacityReservationPreference,

    /// The EC2 capacity reservations that are shared to this ML capacity
    /// reservation, if any.
    ec_2_capacity_reservations: ?[]const Ec2CapacityReservation,

    /// The Amazon Resource Name (ARN) that uniquely identifies the ML capacity
    /// reservation that SageMaker AI applies when it deploys the endpoint.
    ml_reservation_arn: ?[]const u8,

    /// The number of instances that you allocated to the ML capacity reservation.
    total_instance_count: ?i32,

    /// The number of instances from the ML capacity reservation that are being used
    /// by the endpoint.
    used_by_current_endpoint: ?i32,

    pub const json_field_names = .{
        .available_instance_count = "AvailableInstanceCount",
        .capacity_reservation_preference = "CapacityReservationPreference",
        .ec_2_capacity_reservations = "Ec2CapacityReservations",
        .ml_reservation_arn = "MlReservationArn",
        .total_instance_count = "TotalInstanceCount",
        .used_by_current_endpoint = "UsedByCurrentEndpoint",
    };
};
