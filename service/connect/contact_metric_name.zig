pub const ContactMetricName = enum {
    estimated_wait_time,
    position_in_queue,

    pub const json_field_names = .{
        .estimated_wait_time = "ESTIMATED_WAIT_TIME",
        .position_in_queue = "POSITION_IN_QUEUE",
    };
};
