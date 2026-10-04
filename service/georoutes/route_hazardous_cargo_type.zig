const std = @import("std");

pub const RouteHazardousCargoType = enum {
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
        .combustible = "Combustible",
        .corrosive = "Corrosive",
        .explosive = "Explosive",
        .flammable = "Flammable",
        .gas = "Gas",
        .harmful_to_water = "HarmfulToWater",
        .organic = "Organic",
        .other = "Other",
        .poison = "Poison",
        .poisonous_inhalation = "PoisonousInhalation",
        .radioactive = "Radioactive",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .combustible => "Combustible",
            .corrosive => "Corrosive",
            .explosive => "Explosive",
            .flammable => "Flammable",
            .gas => "Gas",
            .harmful_to_water => "HarmfulToWater",
            .organic => "Organic",
            .other => "Other",
            .poison => "Poison",
            .poisonous_inhalation => "PoisonousInhalation",
            .radioactive => "Radioactive",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
