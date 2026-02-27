/// The schedule for running a classification job. Valid values are:
pub const JobType = enum {
    one_time,
    scheduled,

    pub const json_field_names = .{
        .one_time = "ONE_TIME",
        .scheduled = "SCHEDULED",
    };
};
