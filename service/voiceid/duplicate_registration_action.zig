const std = @import("std");

pub const DuplicateRegistrationAction = enum {
    skip,
    register_as_new,

    pub const json_field_names = .{
        .skip = "SKIP",
        .register_as_new = "REGISTER_AS_NEW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .skip => "SKIP",
            .register_as_new => "REGISTER_AS_NEW",
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
