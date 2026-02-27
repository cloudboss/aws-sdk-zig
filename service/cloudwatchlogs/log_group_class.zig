pub const LogGroupClass = enum {
    standard,
    infrequent_access,
    delivery,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .infrequent_access = "INFREQUENT_ACCESS",
        .delivery = "DELIVERY",
    };
};
