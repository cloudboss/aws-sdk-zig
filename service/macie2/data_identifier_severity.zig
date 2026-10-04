const std = @import("std");

/// The severity of a finding, ranging from LOW, for least severe, to HIGH, for
/// most severe. Valid values are:
pub const DataIdentifierSeverity = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
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
