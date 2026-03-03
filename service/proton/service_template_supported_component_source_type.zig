const std = @import("std");

pub const ServiceTemplateSupportedComponentSourceType = enum {
    directly_defined,

    pub const json_field_names = .{
        .directly_defined = "DIRECTLY_DEFINED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .directly_defined => "DIRECTLY_DEFINED",
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
