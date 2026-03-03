const std = @import("std");

pub const ServiceActionDefinitionKey = enum {
    name,
    version,
    assume_role,
    parameters,

    pub const json_field_names = .{
        .name = "Name",
        .version = "Version",
        .assume_role = "AssumeRole",
        .parameters = "Parameters",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .version => "Version",
            .assume_role => "AssumeRole",
            .parameters => "Parameters",
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
