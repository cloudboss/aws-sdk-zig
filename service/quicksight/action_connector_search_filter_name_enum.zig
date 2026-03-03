const std = @import("std");

pub const ActionConnectorSearchFilterNameEnum = enum {
    action_connector_name,
    action_connector_type,
    quicksight_owner,
    quicksight_viewer_or_owner,
    direct_quicksight_sole_owner,
    direct_quicksight_owner,
    direct_quicksight_viewer_or_owner,

    pub const json_field_names = .{
        .action_connector_name = "ACTION_CONNECTOR_NAME",
        .action_connector_type = "ACTION_CONNECTOR_TYPE",
        .quicksight_owner = "QUICKSIGHT_OWNER",
        .quicksight_viewer_or_owner = "QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_connector_name => "ACTION_CONNECTOR_NAME",
            .action_connector_type => "ACTION_CONNECTOR_TYPE",
            .quicksight_owner => "QUICKSIGHT_OWNER",
            .quicksight_viewer_or_owner => "QUICKSIGHT_VIEWER_OR_OWNER",
            .direct_quicksight_sole_owner => "DIRECT_QUICKSIGHT_SOLE_OWNER",
            .direct_quicksight_owner => "DIRECT_QUICKSIGHT_OWNER",
            .direct_quicksight_viewer_or_owner => "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
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
