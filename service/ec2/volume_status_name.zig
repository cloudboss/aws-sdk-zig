const std = @import("std");

pub const VolumeStatusName = enum {
    io_enabled,
    io_performance,
    initialization_state,

    pub const json_field_names = .{
        .io_enabled = "io-enabled",
        .io_performance = "io-performance",
        .initialization_state = "initialization-state",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .io_enabled => "io-enabled",
            .io_performance => "io-performance",
            .initialization_state => "initialization-state",
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
