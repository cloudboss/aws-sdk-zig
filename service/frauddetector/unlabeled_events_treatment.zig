pub const UnlabeledEventsTreatment = enum {
    ignore,
    fraud,
    legit,
    auto,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .fraud = "FRAUD",
        .legit = "LEGIT",
        .auto = "AUTO",
    };
};
