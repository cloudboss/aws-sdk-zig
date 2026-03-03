const std = @import("std");

pub const Platform = enum {
    web,
    web_dynamic,
    web_compute,

    pub const json_field_names = .{
        .web = "WEB",
        .web_dynamic = "WEB_DYNAMIC",
        .web_compute = "WEB_COMPUTE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .web => "WEB",
            .web_dynamic => "WEB_DYNAMIC",
            .web_compute => "WEB_COMPUTE",
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
