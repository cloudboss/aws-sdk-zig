pub const PowerDrawKva = enum {
    power_5_kva,
    power_10_kva,
    power_15_kva,
    power_30_kva,

    pub const json_field_names = .{
        .power_5_kva = "POWER_5_KVA",
        .power_10_kva = "POWER_10_KVA",
        .power_15_kva = "POWER_15_KVA",
        .power_30_kva = "POWER_30_KVA",
    };
};
