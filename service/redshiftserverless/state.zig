pub const State = enum {
    active,
    disabled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .disabled = "DISABLED",
    };
};
