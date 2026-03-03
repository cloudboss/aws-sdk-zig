const std = @import("std");

pub const PivotTableDataPathType = enum {
    hierarchy_rows_layout_column,
    multiple_row_metrics_column,
    empty_column_header,
    count_metric_column,

    pub const json_field_names = .{
        .hierarchy_rows_layout_column = "HIERARCHY_ROWS_LAYOUT_COLUMN",
        .multiple_row_metrics_column = "MULTIPLE_ROW_METRICS_COLUMN",
        .empty_column_header = "EMPTY_COLUMN_HEADER",
        .count_metric_column = "COUNT_METRIC_COLUMN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hierarchy_rows_layout_column => "HIERARCHY_ROWS_LAYOUT_COLUMN",
            .multiple_row_metrics_column => "MULTIPLE_ROW_METRICS_COLUMN",
            .empty_column_header => "EMPTY_COLUMN_HEADER",
            .count_metric_column => "COUNT_METRIC_COLUMN",
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
