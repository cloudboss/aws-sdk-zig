const std = @import("std");

pub const AvailabilityMode = enum {
    zonal,
    regional,

    pub const json_field_names = .{
        .zonal = "zonal",
        .regional = "regional",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zonal => "zonal",
            .regional => "regional",
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
