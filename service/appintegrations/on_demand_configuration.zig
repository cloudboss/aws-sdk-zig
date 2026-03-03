/// The start and end time for data pull from the source.
pub const OnDemandConfiguration = struct {
    /// The end time for data pull from the source as an Unix/epoch string in
    /// milliseconds
    end_time: ?[]const u8 = null,

    /// The start time for data pull from the source as an Unix/epoch string in
    /// milliseconds
    start_time: []const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
