const std = @import("std");

pub const ContributionAnalysisSortType = enum {
    absolute_difference,
    contribution_percentage,
    deviation_from_expected,
    percentage_difference,

    pub const json_field_names = .{
        .absolute_difference = "ABSOLUTE_DIFFERENCE",
        .contribution_percentage = "CONTRIBUTION_PERCENTAGE",
        .deviation_from_expected = "DEVIATION_FROM_EXPECTED",
        .percentage_difference = "PERCENTAGE_DIFFERENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .absolute_difference => "ABSOLUTE_DIFFERENCE",
            .contribution_percentage => "CONTRIBUTION_PERCENTAGE",
            .deviation_from_expected => "DEVIATION_FROM_EXPECTED",
            .percentage_difference => "PERCENTAGE_DIFFERENCE",
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
