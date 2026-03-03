const std = @import("std");

pub const RouteLegTravelMode = enum {
    car,
    ferry,
    pedestrian,
    scooter,
    truck,
    car_shuttle_train,

    pub const json_field_names = .{
        .car = "Car",
        .ferry = "Ferry",
        .pedestrian = "Pedestrian",
        .scooter = "Scooter",
        .truck = "Truck",
        .car_shuttle_train = "CarShuttleTrain",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .car => "Car",
            .ferry => "Ferry",
            .pedestrian => "Pedestrian",
            .scooter => "Scooter",
            .truck => "Truck",
            .car_shuttle_train => "CarShuttleTrain",
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
