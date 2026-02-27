const AwsEc2LaunchTemplateDataCapacityReservationSpecificationCapacityReservationTargetDetails = @import("aws_ec_2_launch_template_data_capacity_reservation_specification_capacity_reservation_target_details.zig").AwsEc2LaunchTemplateDataCapacityReservationSpecificationCapacityReservationTargetDetails;

/// Specifies the Capacity Reservation targeting option of an Amazon EC2
/// instance.
pub const AwsEc2LaunchTemplateDataCapacityReservationSpecificationDetails = struct {
    /// Indicates the instance's Capacity Reservation preferences. If equal to
    /// `open`, the instance can run in any open Capacity Reservation that has
    /// matching attributes (instance type, platform, Availability Zone). If equal
    /// to `none`, the instance avoids running in a Capacity Reservation even if one
    /// is available. The instance runs in On-Demand capacity.
    capacity_reservation_preference: ?[]const u8,

    /// Specifies a target Capacity Reservation.
    capacity_reservation_target: ?AwsEc2LaunchTemplateDataCapacityReservationSpecificationCapacityReservationTargetDetails,

    pub const json_field_names = .{
        .capacity_reservation_preference = "CapacityReservationPreference",
        .capacity_reservation_target = "CapacityReservationTarget",
    };
};
