const std = @import("std");

pub const UplinkGbps = enum {
    uplink_1_g,
    uplink_10_g,
    uplink_40_g,
    uplink_100_g,

    pub const json_field_names = .{
        .uplink_1_g = "UPLINK_1G",
        .uplink_10_g = "UPLINK_10G",
        .uplink_40_g = "UPLINK_40G",
        .uplink_100_g = "UPLINK_100G",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .uplink_1_g => "UPLINK_1G",
            .uplink_10_g => "UPLINK_10G",
            .uplink_40_g => "UPLINK_40G",
            .uplink_100_g => "UPLINK_100G",
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
