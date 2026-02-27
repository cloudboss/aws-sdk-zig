pub const StatusType = enum {
    detected,
    missed,

    pub const json_field_names = .{
        .detected = "DETECTED",
        .missed = "MISSED",
    };
};
