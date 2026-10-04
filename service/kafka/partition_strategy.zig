const std = @import("std");

/// The partitioning strategy used to partition records in the destination
/// Apache Iceberg table.
pub const PartitionStrategy = enum {
    time_hour,

    pub const json_field_names = .{
        .time_hour = "TIME_HOUR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .time_hour => "TIME_HOUR",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
