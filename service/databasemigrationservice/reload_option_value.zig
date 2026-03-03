const std = @import("std");

pub const ReloadOptionValue = enum {
    data_reload,
    validate_only,

    pub const json_field_names = .{
        .data_reload = "data-reload",
        .validate_only = "validate-only",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_reload => "data-reload",
            .validate_only => "validate-only",
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
