const std = @import("std");

pub const SpaceQuickSightSearchFilterName = enum {
    space_id,
    space_name,
    direct_quicksight_owner,
    direct_quicksight_viewer_or_owner,
    direct_quicksight_sole_owner,
    contributed_by,
    consumed_source_size,
    created_by,

    pub const json_field_names = .{
        .space_id = "SPACE_ID",
        .space_name = "SPACE_NAME",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .contributed_by = "CONTRIBUTED_BY",
        .consumed_source_size = "CONSUMED_SOURCE_SIZE",
        .created_by = "CREATED_BY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .space_id => "SPACE_ID",
            .space_name => "SPACE_NAME",
            .direct_quicksight_owner => "DIRECT_QUICKSIGHT_OWNER",
            .direct_quicksight_viewer_or_owner => "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
            .direct_quicksight_sole_owner => "DIRECT_QUICKSIGHT_SOLE_OWNER",
            .contributed_by => "CONTRIBUTED_BY",
            .consumed_source_size => "CONSUMED_SOURCE_SIZE",
            .created_by => "CREATED_BY",
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
