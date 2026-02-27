/// Campaign schedule
pub const Schedule = struct {
    end_time: i64,

    refresh_frequency: ?[]const u8,

    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .refresh_frequency = "refreshFrequency",
        .start_time = "startTime",
    };
};
