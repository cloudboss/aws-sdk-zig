/// Contains details about errors encountered during instance launch attempts.
pub const LaunchInstancesError = struct {
    /// The Availability Zone where the instance launch was attempted.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID where the launch error occurred.
    availability_zone_id: ?[]const u8 = null,

    /// The error code representing the type of error encountered (e.g.,
    /// InsufficientInstanceCapacity).
    error_code: ?[]const u8 = null,

    /// A descriptive message providing details about the error encountered during
    /// the launch attempt.
    error_message: ?[]const u8 = null,

    /// The instance type that failed to launch.
    instance_type: ?[]const u8 = null,

    /// The market type (On-Demand or Spot) that encountered the launch error.
    market_type: ?[]const u8 = null,

    /// The subnet ID where the instance launch was attempted.
    subnet_id: ?[]const u8 = null,
};
