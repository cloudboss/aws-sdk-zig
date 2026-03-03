const std = @import("std");

pub const Objective = enum {
    auto,
    balanced,
    basic,
    high_throughput,
    low_latency,

    pub const json_field_names = .{
        .auto = "AUTO",
        .balanced = "BALANCED",
        .basic = "BASIC",
        .high_throughput = "HIGH_THROUGHPUT",
        .low_latency = "LOW_LATENCY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .balanced => "BALANCED",
            .basic => "BASIC",
            .high_throughput => "HIGH_THROUGHPUT",
            .low_latency => "LOW_LATENCY",
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
