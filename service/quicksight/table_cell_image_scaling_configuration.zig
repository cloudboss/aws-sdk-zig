const std = @import("std");

pub const TableCellImageScalingConfiguration = enum {
    fit_to_cell_height,
    fit_to_cell_width,
    do_not_scale,

    pub const json_field_names = .{
        .fit_to_cell_height = "FIT_TO_CELL_HEIGHT",
        .fit_to_cell_width = "FIT_TO_CELL_WIDTH",
        .do_not_scale = "DO_NOT_SCALE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fit_to_cell_height => "FIT_TO_CELL_HEIGHT",
            .fit_to_cell_width => "FIT_TO_CELL_WIDTH",
            .do_not_scale => "DO_NOT_SCALE",
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
