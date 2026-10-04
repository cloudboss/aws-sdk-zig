const std = @import("std");

pub const AnalysisType = enum {
    max_savings,
    custom_commitment,
    target_average_coverage,

    pub const json_field_names = .{
        .max_savings = "MAX_SAVINGS",
        .custom_commitment = "CUSTOM_COMMITMENT",
        .target_average_coverage = "TARGET_AVERAGE_COVERAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .max_savings => "MAX_SAVINGS",
            .custom_commitment => "CUSTOM_COMMITMENT",
            .target_average_coverage => "TARGET_AVERAGE_COVERAGE",
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
