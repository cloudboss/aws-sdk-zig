/// Contains information on unusual and impossible travel in an account.
pub const ImpossibleTravelDetail = struct {
    /// IP address where the resource was last used in the impossible travel.
    ending_ip_address: ?[]const u8 = null,

    /// Location where the resource was last used in the impossible travel.
    ending_location: ?[]const u8 = null,

    /// Returns the time difference between the first and last timestamp the
    /// resource was used.
    hourly_time_delta: ?i32 = null,

    /// IP address where the resource was first used in the impossible travel.
    starting_ip_address: ?[]const u8 = null,

    /// Location where the resource was first used in the impossible travel.
    starting_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .ending_ip_address = "EndingIpAddress",
        .ending_location = "EndingLocation",
        .hourly_time_delta = "HourlyTimeDelta",
        .starting_ip_address = "StartingIpAddress",
        .starting_location = "StartingLocation",
    };
};
