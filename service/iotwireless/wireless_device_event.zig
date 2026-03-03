const std = @import("std");

/// The event for a log message, if the log message is tied to a wireless
/// device.
pub const WirelessDeviceEvent = enum {
    join,
    rejoin,
    uplink_data,
    downlink_data,
    registration,

    pub const json_field_names = .{
        .join = "Join",
        .rejoin = "Rejoin",
        .uplink_data = "Uplink_Data",
        .downlink_data = "Downlink_Data",
        .registration = "Registration",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .join => "Join",
            .rejoin => "Rejoin",
            .uplink_data => "Uplink_Data",
            .downlink_data => "Downlink_Data",
            .registration => "Registration",
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
