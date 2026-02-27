pub const SpotInstanceTypeEnum = enum {
    one_time,
    persistent,

    pub const json_field_names = .{
        .one_time = "ONE_TIME",
        .persistent = "PERSISTENT",
    };
};
