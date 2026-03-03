const std = @import("std");

pub const ReportGroupTrendFieldType = enum {
    pass_rate,
    duration,
    total,
    line_coverage,
    lines_covered,
    lines_missed,
    branch_coverage,
    branches_covered,
    branches_missed,

    pub const json_field_names = .{
        .pass_rate = "PASS_RATE",
        .duration = "DURATION",
        .total = "TOTAL",
        .line_coverage = "LINE_COVERAGE",
        .lines_covered = "LINES_COVERED",
        .lines_missed = "LINES_MISSED",
        .branch_coverage = "BRANCH_COVERAGE",
        .branches_covered = "BRANCHES_COVERED",
        .branches_missed = "BRANCHES_MISSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pass_rate => "PASS_RATE",
            .duration => "DURATION",
            .total => "TOTAL",
            .line_coverage => "LINE_COVERAGE",
            .lines_covered => "LINES_COVERED",
            .lines_missed => "LINES_MISSED",
            .branch_coverage => "BRANCH_COVERAGE",
            .branches_covered => "BRANCHES_COVERED",
            .branches_missed => "BRANCHES_MISSED",
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
