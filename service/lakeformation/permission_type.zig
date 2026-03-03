const std = @import("std");

pub const PermissionType = enum {
    column_permission,
    cell_filter_permission,
    nested_permission,
    nested_cell_permission,

    pub const json_field_names = .{
        .column_permission = "COLUMN_PERMISSION",
        .cell_filter_permission = "CELL_FILTER_PERMISSION",
        .nested_permission = "NESTED_PERMISSION",
        .nested_cell_permission = "NESTED_CELL_PERMISSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .column_permission => "COLUMN_PERMISSION",
            .cell_filter_permission => "CELL_FILTER_PERMISSION",
            .nested_permission => "NESTED_PERMISSION",
            .nested_cell_permission => "NESTED_CELL_PERMISSION",
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
