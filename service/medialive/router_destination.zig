/// Placeholder documentation for RouterDestination
pub const RouterDestination = struct {
    /// The Availability Zone (AZ) names of the AZs this destination is created in.
    availability_zone_name: ?[]const u8,

    /// ARN of the output from MediaConnect Router currently connected to this
    /// input.
    router_output_arn: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone_name = "AvailabilityZoneName",
        .router_output_arn = "RouterOutputArn",
    };
};
