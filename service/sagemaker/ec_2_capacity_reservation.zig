/// The EC2 capacity reservations that are shared to an ML capacity reservation.
pub const Ec2CapacityReservation = struct {
    /// The number of instances that are currently available in the EC2 capacity
    /// reservation.
    available_instance_count: ?i32,

    /// The unique identifier for an EC2 capacity reservation that's part of the ML
    /// capacity reservation.
    ec_2_capacity_reservation_id: ?[]const u8,

    /// The number of instances that you allocated to the EC2 capacity reservation.
    total_instance_count: ?i32,

    /// The number of instances from the EC2 capacity reservation that are being
    /// used by the endpoint.
    used_by_current_endpoint: ?i32,

    pub const json_field_names = .{
        .available_instance_count = "AvailableInstanceCount",
        .ec_2_capacity_reservation_id = "Ec2CapacityReservationId",
        .total_instance_count = "TotalInstanceCount",
        .used_by_current_endpoint = "UsedByCurrentEndpoint",
    };
};
