const std = @import("std");

/// The type of replication starting position.
pub const ReplicationStartingPositionType = enum {
    latest,
    earliest,

    pub const json_field_names = .{
        .latest = "LATEST",
        .earliest = "EARLIEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .latest => "LATEST",
            .earliest => "EARLIEST",
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
