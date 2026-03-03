/// The EC2 capacity reservations that are shared to an ML capacity reservation.
pub const Ec2CapacityReservation = struct {
    /// The number of instances that are currently available in the EC2 capacity
    /// reservation.
    available_instance_count: ?i32 = null,

    /// The unique identifier for an EC2 capacity reservation that's part of the ML
    /// capacity reservation.
    ec_2_capacity_reservation_id: ?[]const u8 = null,

    /// The number of instances that you allocated to the EC2 capacity reservation.
    total_instance_count: ?i32 = null,

    /// The number of instances from the EC2 capacity reservation that are being
    /// used by the endpoint.
    used_by_current_endpoint: ?i32 = null,

    pub const json_field_names = .{
        .available_instance_count = "AvailableInstanceCount",
        .ec_2_capacity_reservation_id = "Ec2CapacityReservationId",
        .total_instance_count = "TotalInstanceCount",
        .used_by_current_endpoint = "UsedByCurrentEndpoint",
    };
};
