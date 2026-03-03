const std = @import("std");

pub const FieldName = enum {
    flow_name,
    flow_description,
    direct_quicksight_owner,
    direct_quicksight_viewer_or_owner,
    direct_quicksight_sole_owner,

    pub const json_field_names = .{
        .flow_name = "assetName",
        .flow_description = "assetDescription",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .flow_name => "assetName",
            .flow_description => "assetDescription",
            .direct_quicksight_owner => "DIRECT_QUICKSIGHT_OWNER",
            .direct_quicksight_viewer_or_owner => "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
            .direct_quicksight_sole_owner => "DIRECT_QUICKSIGHT_SOLE_OWNER",
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
