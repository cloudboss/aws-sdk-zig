pub const OfferingClass = enum {
    standard,
    convertible,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .convertible = "CONVERTIBLE",
    };
};
