const std = @import("std");

/// The field to sort user index capacity results by.
pub const UserIndexCapacitySortBy = enum {
    total_capacity_bytes,

    pub const json_field_names = .{
        .total_capacity_bytes = "TOTAL_CAPACITY_BYTES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .total_capacity_bytes => "TOTAL_CAPACITY_BYTES",
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
