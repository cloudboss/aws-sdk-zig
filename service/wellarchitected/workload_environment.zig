const std = @import("std");

/// The environment for the workload.
pub const WorkloadEnvironment = enum {
    production,
    preproduction,

    pub const json_field_names = .{
        .production = "PRODUCTION",
        .preproduction = "PREPRODUCTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .production => "PRODUCTION",
            .preproduction => "PREPRODUCTION",
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
