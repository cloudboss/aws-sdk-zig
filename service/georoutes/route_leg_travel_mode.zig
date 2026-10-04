const std = @import("std");

pub const RouteLegTravelMode = enum {
    car,
    ferry,
    pedestrian,
    scooter,
    truck,
    car_shuttle_train,
    aerial_tramway,
    airplane,
    bus,
    bus_rapid_transit,
    city_train,
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
        .car = "Car",
        .ferry = "Ferry",
        .pedestrian = "Pedestrian",
        .scooter = "Scooter",
        .truck = "Truck",
        .car_shuttle_train = "CarShuttleTrain",
        .aerial_tramway = "AerialTramway",
        .airplane = "Airplane",
        .bus = "Bus",
        .bus_rapid_transit = "BusRapidTransit",
        .city_train = "CityTrain",
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
            .car => "Car",
            .ferry => "Ferry",
            .pedestrian => "Pedestrian",
            .scooter => "Scooter",
            .truck => "Truck",
            .car_shuttle_train => "CarShuttleTrain",
            .aerial_tramway => "AerialTramway",
            .airplane => "Airplane",
            .bus => "Bus",
            .bus_rapid_transit => "BusRapidTransit",
            .city_train => "CityTrain",
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
