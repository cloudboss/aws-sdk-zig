const std = @import("std");

pub const ForecastedGeofenceEventType = enum {
    /// This event type signifies that a device is forecasted to enter the geofence
    enter,
    /// This event type signifies that a device is forecasted to exit the geofence
    exit,
    /// This event type signifies that a device is stationary in the geofence and an
    /// exit/enter cannot be forecasted
    idle,

    pub const json_field_names = .{
        .enter = "ENTER",
        .exit = "EXIT",
        .idle = "IDLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enter => "ENTER",
            .exit => "EXIT",
            .idle => "IDLE",
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
