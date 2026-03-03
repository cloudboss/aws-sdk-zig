const std = @import("std");

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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
