pub const PortInfoSourceType = enum {
    default,
    instance,
    none,
    closed,

    pub const json_field_names = .{
        .default = "Default",
        .instance = "Instance",
        .none = "None",
        .closed = "Closed",
    };
};
