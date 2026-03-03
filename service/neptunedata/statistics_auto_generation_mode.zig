const std = @import("std");

pub const StatisticsAutoGenerationMode = enum {
    disable_autocompute,
    enable_autocompute,
    refresh,

    pub const json_field_names = .{
        .disable_autocompute = "disableAutoCompute",
        .enable_autocompute = "enableAutoCompute",
        .refresh = "refresh",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disable_autocompute => "disableAutoCompute",
            .enable_autocompute => "enableAutoCompute",
            .refresh => "refresh",
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
