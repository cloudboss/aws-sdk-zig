const std = @import("std");

/// The purpose of a test monitoring source.
pub const TestSourceType = enum {
    success_criteria,
    observability,

    pub const json_field_names = .{
        .success_criteria = "SUCCESS_CRITERIA",
        .observability = "OBSERVABILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success_criteria => "SUCCESS_CRITERIA",
            .observability => "OBSERVABILITY",
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
