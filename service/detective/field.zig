pub const Field = enum {
    severity,
    status,
    created_time,

    pub const json_field_names = .{
        .severity = "SEVERITY",
        .status = "STATUS",
        .created_time = "CREATED_TIME",
    };
};
