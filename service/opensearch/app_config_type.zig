const std = @import("std");

pub const AppConfigType = enum {
    opensearch_dashboard_admin_users,
    opensearch_dashboard_admin_groups,

    pub const json_field_names = .{
        .opensearch_dashboard_admin_users = "opensearchDashboards.dashboardAdmin.users",
        .opensearch_dashboard_admin_groups = "opensearchDashboards.dashboardAdmin.groups",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .opensearch_dashboard_admin_users => "opensearchDashboards.dashboardAdmin.users",
            .opensearch_dashboard_admin_groups => "opensearchDashboards.dashboardAdmin.groups",
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
