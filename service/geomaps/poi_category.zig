const std = @import("std");

pub const PoiCategory = enum {
    food_and_drink,
    entertainment,
    sights_and_museums,
    transportation,
    accommodations,
    leisure_and_outdoor,
    shopping,
    business_and_services,
    facilities_and_buildings,

    pub const json_field_names = .{
        .food_and_drink = "FoodAndDrink",
        .entertainment = "Entertainment",
        .sights_and_museums = "SightsAndMuseums",
        .transportation = "Transportation",
        .accommodations = "Accommodations",
        .leisure_and_outdoor = "LeisureAndOutdoor",
        .shopping = "Shopping",
        .business_and_services = "BusinessAndServices",
        .facilities_and_buildings = "FacilitiesAndBuildings",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .food_and_drink => "FoodAndDrink",
            .entertainment => "Entertainment",
            .sights_and_museums => "SightsAndMuseums",
            .transportation => "Transportation",
            .accommodations => "Accommodations",
            .leisure_and_outdoor => "LeisureAndOutdoor",
            .shopping => "Shopping",
            .business_and_services => "BusinessAndServices",
            .facilities_and_buildings => "FacilitiesAndBuildings",
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
