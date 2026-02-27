pub const Status = enum {
    ignore,
    resolved,
    pending,
    recurring,
    recovering,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .resolved = "RESOLVED",
        .pending = "PENDING",
        .recurring = "RECURRING",
        .recovering = "RECOVERING",
    };
};
