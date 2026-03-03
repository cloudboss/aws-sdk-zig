const std = @import("std");

pub const DashboardFilterAttribute = enum {
    quicksight_user,
    quicksight_viewer_or_owner,
    direct_quicksight_viewer_or_owner,
    quicksight_owner,
    direct_quicksight_owner,
    direct_quicksight_sole_owner,
    dashboard_name,

    pub const json_field_names = .{
        .quicksight_user = "QUICKSIGHT_USER",
        .quicksight_viewer_or_owner = "QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .quicksight_owner = "QUICKSIGHT_OWNER",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .dashboard_name = "DASHBOARD_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .quicksight_user => "QUICKSIGHT_USER",
            .quicksight_viewer_or_owner => "QUICKSIGHT_VIEWER_OR_OWNER",
            .direct_quicksight_viewer_or_owner => "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
            .quicksight_owner => "QUICKSIGHT_OWNER",
            .direct_quicksight_owner => "DIRECT_QUICKSIGHT_OWNER",
            .direct_quicksight_sole_owner => "DIRECT_QUICKSIGHT_SOLE_OWNER",
            .dashboard_name => "DASHBOARD_NAME",
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
