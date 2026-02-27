pub const Role = enum {
    controller,
    device,

    pub const json_field_names = .{
        .controller = "CONTROLLER",
        .device = "DEVICE",
    };
};
