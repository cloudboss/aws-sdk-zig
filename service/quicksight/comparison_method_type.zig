const std = @import("std");

pub const ComparisonMethodType = enum {
    diff,
    perc_diff,
    diff_as_perc,
    pop_current_diff_as_perc,
    pop_current_diff,
    pop_overtime_diff_as_perc,
    pop_overtime_diff,
    percent_of_total,
    running_sum,
    moving_average,

    pub const json_field_names = .{
        .diff = "DIFF",
        .perc_diff = "PERC_DIFF",
        .diff_as_perc = "DIFF_AS_PERC",
        .pop_current_diff_as_perc = "POP_CURRENT_DIFF_AS_PERC",
        .pop_current_diff = "POP_CURRENT_DIFF",
        .pop_overtime_diff_as_perc = "POP_OVERTIME_DIFF_AS_PERC",
        .pop_overtime_diff = "POP_OVERTIME_DIFF",
        .percent_of_total = "PERCENT_OF_TOTAL",
        .running_sum = "RUNNING_SUM",
        .moving_average = "MOVING_AVERAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .diff => "DIFF",
            .perc_diff => "PERC_DIFF",
            .diff_as_perc => "DIFF_AS_PERC",
            .pop_current_diff_as_perc => "POP_CURRENT_DIFF_AS_PERC",
            .pop_current_diff => "POP_CURRENT_DIFF",
            .pop_overtime_diff_as_perc => "POP_OVERTIME_DIFF_AS_PERC",
            .pop_overtime_diff => "POP_OVERTIME_DIFF",
            .percent_of_total => "PERCENT_OF_TOTAL",
            .running_sum => "RUNNING_SUM",
            .moving_average => "MOVING_AVERAGE",
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
