pub const NetworkFabricType = enum {
    transit_gateway,
    none,

    pub const json_field_names = .{
        .transit_gateway = "TRANSIT_GATEWAY",
        .none = "NONE",
    };
};
