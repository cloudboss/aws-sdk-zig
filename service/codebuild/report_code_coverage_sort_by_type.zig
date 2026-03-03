const std = @import("std");

pub const ReportCodeCoverageSortByType = enum {
    line_coverage_percentage,
    file_path,

    pub const json_field_names = .{
        .line_coverage_percentage = "LINE_COVERAGE_PERCENTAGE",
        .file_path = "FILE_PATH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .line_coverage_percentage => "LINE_COVERAGE_PERCENTAGE",
            .file_path => "FILE_PATH",
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
