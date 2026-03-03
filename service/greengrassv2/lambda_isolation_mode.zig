const std = @import("std");

pub const LambdaIsolationMode = enum {
    greengrass_container,
    no_container,

    pub const json_field_names = .{
        .greengrass_container = "GreengrassContainer",
        .no_container = "NoContainer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greengrass_container => "GreengrassContainer",
            .no_container => "NoContainer",
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
