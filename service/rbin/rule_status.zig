pub const RuleStatus = enum {
    pending,
    available,

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
    };
};
