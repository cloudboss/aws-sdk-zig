const std = @import("std");

pub const RouteTransitMode = enum {
    aerial_tramway,
    airplane,
    all,
    bus,
    bus_rapid_transit,
    city_train,
    ferry,
    funicular_railway,
    high_speed_train,
    intercity_train,
    interregional_train,
    light_rail,
    monorail,
    private_bus,
    regional_train,
    subway,

    pub const json_field_names = .{
        .aerial_tramway = "AerialTramway",
        .airplane = "Airplane",
        .all = "All",
        .bus = "Bus",
        .bus_rapid_transit = "BusRapidTransit",
        .city_train = "CityTrain",
        .ferry = "Ferry",
        .funicular_railway = "FunicularRailway",
        .high_speed_train = "HighSpeedTrain",
        .intercity_train = "IntercityTrain",
        .interregional_train = "InterregionalTrain",
        .light_rail = "LightRail",
        .monorail = "Monorail",
        .private_bus = "PrivateBus",
        .regional_train = "RegionalTrain",
        .subway = "Subway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aerial_tramway => "AerialTramway",
            .airplane => "Airplane",
            .all => "All",
            .bus => "Bus",
            .bus_rapid_transit => "BusRapidTransit",
            .city_train => "CityTrain",
            .ferry => "Ferry",
            .funicular_railway => "FunicularRailway",
            .high_speed_train => "HighSpeedTrain",
            .intercity_train => "IntercityTrain",
            .interregional_train => "InterregionalTrain",
            .light_rail => "LightRail",
            .monorail => "Monorail",
            .private_bus => "PrivateBus",
            .regional_train => "RegionalTrain",
            .subway => "Subway",
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
