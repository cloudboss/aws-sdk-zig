pub const DataSourceStatus = enum {
    active,
    disabled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .disabled = "DISABLED",
    };
};
