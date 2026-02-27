/// Defines the details of a high availability configuration.
pub const HighAvailabilityConfig = struct {
    /// The number of instances in a high availability configuration. The minimum
    /// possible value is 1 and the maximum is 100.
    desired_capacity: i32,

    pub const json_field_names = .{
        .desired_capacity = "desiredCapacity",
    };
};
