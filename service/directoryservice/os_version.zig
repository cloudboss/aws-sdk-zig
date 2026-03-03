const std = @import("std");

pub const OSVersion = enum {
    version_2012,
    version_2019,

    pub const json_field_names = .{
        .version_2012 = "SERVER_2012",
        .version_2019 = "SERVER_2019",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .version_2012 => "SERVER_2012",
            .version_2019 => "SERVER_2019",
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
