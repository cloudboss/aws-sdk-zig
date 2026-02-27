const AvailabilityZoneInfo = @import("availability_zone_info.zig").AvailabilityZoneInfo;

/// Information about the active domain environment.
pub const EnvironmentInfo = struct {
    /// A list of `AvailabilityZoneInfo` for the domain.
    availability_zone_information: ?[]const AvailabilityZoneInfo,

    pub const json_field_names = .{
        .availability_zone_information = "AvailabilityZoneInformation",
    };
};
