pub const InstanceStatus = enum {
    pending,
    active,
    terminating,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .terminating = "TERMINATING",
    };
};
