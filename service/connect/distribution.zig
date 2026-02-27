/// Information about a traffic distribution.
pub const Distribution = struct {
    /// The percentage of the traffic that is distributed, in increments of 10.
    percentage: i32 = 0,

    /// The Amazon Web Services Region where the traffic is distributed.
    region: []const u8,

    pub const json_field_names = .{
        .percentage = "Percentage",
        .region = "Region",
    };
};
