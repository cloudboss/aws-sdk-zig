pub const NumberScale = enum {
    none,
    auto,
    thousands,
    millions,
    billions,
    trillions,
    lakhs,
    crores,

    pub const json_field_names = .{
        .none = "NONE",
        .auto = "AUTO",
        .thousands = "THOUSANDS",
        .millions = "MILLIONS",
        .billions = "BILLIONS",
        .trillions = "TRILLIONS",
        .lakhs = "LAKHS",
        .crores = "CRORES",
    };
};
