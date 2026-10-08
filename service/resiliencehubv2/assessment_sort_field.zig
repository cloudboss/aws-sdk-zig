const std = @import("std");

/// The field by which to sort failure mode assessment results.
pub const AssessmentSortField = enum {
    started_at,

    pub const json_field_names = .{
        .started_at = "STARTED_AT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .started_at => "STARTED_AT",
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
