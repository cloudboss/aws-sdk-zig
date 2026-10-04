const std = @import("std");

pub const ClientCompatibilityV4 = enum {
    windows_server_2012,
    windows_server_2012_r2,
    windows_server_2016,

    pub const json_field_names = .{
        .windows_server_2012 = "WINDOWS_SERVER_2012",
        .windows_server_2012_r2 = "WINDOWS_SERVER_2012_R2",
        .windows_server_2016 = "WINDOWS_SERVER_2016",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows_server_2012 => "WINDOWS_SERVER_2012",
            .windows_server_2012_r2 => "WINDOWS_SERVER_2012_R2",
            .windows_server_2016 => "WINDOWS_SERVER_2016",
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
