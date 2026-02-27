pub const NetworkInterfaceType = enum {
    ena,
    efa,

    pub const json_field_names = .{
        .ena = "ena",
        .efa = "efa",
    };
};
