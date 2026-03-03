const std = @import("std");

pub const APISchemaType = enum {
    open_api_v3,

    pub const json_field_names = .{
        .open_api_v3 = "OPEN_API_V3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open_api_v3 => "OPEN_API_V3",
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
