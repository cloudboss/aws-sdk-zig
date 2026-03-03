const std = @import("std");

pub const BatchReportModeType = enum {
    report_individual_builds,
    report_aggregated_batch,

    pub const json_field_names = .{
        .report_individual_builds = "REPORT_INDIVIDUAL_BUILDS",
        .report_aggregated_batch = "REPORT_AGGREGATED_BATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .report_individual_builds => "REPORT_INDIVIDUAL_BUILDS",
            .report_aggregated_batch => "REPORT_AGGREGATED_BATCH",
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
