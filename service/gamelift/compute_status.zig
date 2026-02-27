pub const ComputeStatus = enum {
    pending,
    active,
    terminating,
    impaired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .terminating = "TERMINATING",
        .impaired = "IMPAIRED",
    };
};
