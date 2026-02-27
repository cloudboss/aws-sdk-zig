pub const DriftStatus = enum {
    not_checked,
    not_detected,
    detected,

    pub const json_field_names = .{
        .not_checked = "NOT_CHECKED",
        .not_detected = "NOT_DETECTED",
        .detected = "DETECTED",
    };
};
