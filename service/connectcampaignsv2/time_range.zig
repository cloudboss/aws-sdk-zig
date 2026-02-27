/// Time range in 24 hour format
pub const TimeRange = struct {
    end_time: []const u8,

    start_time: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
