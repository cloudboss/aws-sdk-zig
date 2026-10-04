const std = @import("std");

/// Optional. When you request lists of resources, you can specify whether they
/// are sorted in ASCENDING or DESCENDING order. Default varies by resource.
pub const Order = enum {
    ascending,
    descending,

    pub const json_field_names = .{
        .ascending = "ASCENDING",
        .descending = "DESCENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ascending => "ASCENDING",
            .descending => "DESCENDING",
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
