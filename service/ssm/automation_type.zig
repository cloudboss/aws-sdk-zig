pub const AutomationType = enum {
    cross_account,
    local,

    pub const json_field_names = .{
        .cross_account = "CrossAccount",
        .local = "Local",
    };
};
