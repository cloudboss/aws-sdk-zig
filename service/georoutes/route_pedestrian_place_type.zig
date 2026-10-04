const std = @import("std");

pub const RoutePedestrianPlaceType = enum {
    access_point,
    docking_station,
    parking_lot,
    station,

    pub const json_field_names = .{
        .access_point = "AccessPoint",
        .docking_station = "DockingStation",
        .parking_lot = "ParkingLot",
        .station = "Station",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_point => "AccessPoint",
            .docking_station => "DockingStation",
            .parking_lot => "ParkingLot",
            .station => "Station",
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
