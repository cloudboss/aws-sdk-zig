const std = @import("std");

pub const ConfigurationSource = enum {
    repository,
    api,

    pub const json_field_names = .{
        .repository = "REPOSITORY",
        .api = "API",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .repository => "REPOSITORY",
            .api => "API",
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
