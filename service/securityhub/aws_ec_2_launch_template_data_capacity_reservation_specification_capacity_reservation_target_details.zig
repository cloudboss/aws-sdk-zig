/// Information about the target Capacity Reservation or Capacity Reservation
/// group in which to run an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataCapacityReservationSpecificationCapacityReservationTargetDetails = struct {
    /// The ID of the Capacity Reservation in which to run the instance.
    capacity_reservation_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Capacity Reservation resource group in
    /// which to run the instance.
    capacity_reservation_resource_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_reservation_id = "CapacityReservationId",
        .capacity_reservation_resource_group_arn = "CapacityReservationResourceGroupArn",
    };
};
