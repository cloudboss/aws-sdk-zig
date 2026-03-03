const std = @import("std");

pub const Operation = enum {
    enable_scanning,
    disable_scanning,
    enable_repository,
    disable_repository,

    pub const json_field_names = .{
        .enable_scanning = "ENABLE_SCANNING",
        .disable_scanning = "DISABLE_SCANNING",
        .enable_repository = "ENABLE_REPOSITORY",
        .disable_repository = "DISABLE_REPOSITORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enable_scanning => "ENABLE_SCANNING",
            .disable_scanning => "DISABLE_SCANNING",
            .enable_repository => "ENABLE_REPOSITORY",
            .disable_repository => "DISABLE_REPOSITORY",
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
