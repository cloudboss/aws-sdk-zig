const std = @import("std");

pub const MigrationTypeValue = enum {
    full_load,
    cdc,
    full_load_and_cdc,

    pub const json_field_names = .{
        .full_load = "full-load",
        .cdc = "cdc",
        .full_load_and_cdc = "full-load-and-cdc",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_load => "full-load",
            .cdc => "cdc",
            .full_load_and_cdc => "full-load-and-cdc",
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
