pub const Mode = enum {
    delivery,
    filter,

    pub const json_field_names = .{
        .delivery = "DELIVERY",
        .filter = "FILTER",
    };
};
