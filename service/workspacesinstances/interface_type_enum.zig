pub const InterfaceTypeEnum = enum {
    interface,
    efa,
    efa_only,

    pub const json_field_names = .{
        .interface = "INTERFACE",
        .efa = "EFA",
        .efa_only = "EFA_ONLY",
    };
};
