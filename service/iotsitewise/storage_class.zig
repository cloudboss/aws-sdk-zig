const std = @import("std");

/// The storage type that determines I/O performance characteristics. Family
/// name indicates workload pattern, level number indicates performance within
/// that family.
pub const StorageClass = enum {
    standard_1,
    standard_2,
    throughput_1,
    throughput_2,

    pub const json_field_names = .{
        .standard_1 = "STANDARD_1",
        .standard_2 = "STANDARD_2",
        .throughput_1 = "THROUGHPUT_1",
        .throughput_2 = "THROUGHPUT_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard_1 => "STANDARD_1",
            .standard_2 => "STANDARD_2",
            .throughput_1 => "THROUGHPUT_1",
            .throughput_2 => "THROUGHPUT_2",
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
