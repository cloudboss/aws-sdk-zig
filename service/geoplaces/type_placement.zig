const std = @import("std");

pub const TypePlacement = enum {
    before_base_name,
    after_base_name,

    pub const json_field_names = .{
        .before_base_name = "BeforeBaseName",
        .after_base_name = "AfterBaseName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_base_name => "BeforeBaseName",
            .after_base_name => "AfterBaseName",
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
