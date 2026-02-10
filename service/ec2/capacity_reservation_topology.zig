/// Information about the Capacity Reservation topology.
pub const CapacityReservationTopology = struct {
    /// The name of the Availability Zone or Local Zone that the Capacity
    /// Reservation is
    /// in.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone or Local Zone that the Capacity Reservation
    /// is
    /// in.
    availability_zone_id: ?[]const u8,

    /// The ID of the Capacity Block. This parameter is only supported for
    /// UltraServer
    /// instances and identifies instances within the UltraServer domain.
    capacity_block_id: ?[]const u8,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8,

    /// The name of the placement group that the Capacity Reservation is in.
    group_name: ?[]const u8,

    /// The instance type.
    instance_type: ?[]const u8,

    /// The network nodes. The nodes are hashed based on your account. Capacity
    /// Reservations
    /// from different accounts running under the same server will return a
    /// different hashed
    /// list of strings.
    ///
    /// The value is `null` or empty if:
    ///
    /// * The instance type is not supported.
    ///
    /// * The Capacity Reservation is in a state other than `active` or
    /// `pending`.
    network_nodes: ?[]const []const u8,

    /// The current state of the Capacity Reservation. For the list of possible
    /// states, see
    /// [DescribeCapacityReservations](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeCapacityReservations.html).
    state: ?[]const u8,
};
