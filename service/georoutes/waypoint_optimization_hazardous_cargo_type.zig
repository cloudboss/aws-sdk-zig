pub const WaypointOptimizationHazardousCargoType = enum {
    combustible,
    corrosive,
    explosive,
    flammable,
    gas,
    harmful_to_water,
    organic,
    other,
    poison,
    poisonous_inhalation,
    radioactive,

    pub const json_field_names = .{
        .combustible = "COMBUSTIBLE",
        .corrosive = "CORROSIVE",
        .explosive = "EXPLOSIVE",
        .flammable = "FLAMMABLE",
        .gas = "GAS",
        .harmful_to_water = "HARMFUL_TO_WATER",
        .organic = "ORGANIC",
        .other = "OTHER",
        .poison = "POISON",
        .poisonous_inhalation = "POISONOUS_INHALATION",
        .radioactive = "RADIOACTIVE",
    };
};
