const CapacityReservation = @import("capacity_reservation.zig").CapacityReservation;

/// Metadata information about an instance group in a HyperPod cluster.
pub const InstanceGroupMetadata = struct {
    /// If you use a custom Amazon Machine Image (AMI) for the instance group, this
    /// field shows the ID of the custom AMI.
    ami_override: ?[]const u8 = null,

    /// The ID of the Availability Zone where the instance group is located.
    availability_zone_id: ?[]const u8 = null,

    /// Information about the Capacity Reservation used by the instance group.
    capacity_reservation: ?CapacityReservation = null,

    /// An error message describing why the instance group level operation (such as
    /// creating, scaling, or deleting) failed.
    failure_message: ?[]const u8 = null,

    /// A list of security group IDs associated with the instance group.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID of the subnet where the instance group is located.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ami_override = "AmiOverride",
        .availability_zone_id = "AvailabilityZoneId",
        .capacity_reservation = "CapacityReservation",
        .failure_message = "FailureMessage",
        .security_group_ids = "SecurityGroupIds",
        .subnet_id = "SubnetId",
    };
};
