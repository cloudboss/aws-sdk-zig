const std = @import("std");

pub const StatusReason = enum {
    data_source_access_denied,
    execution_role_assume_failed,
    execution_role_insufficient_permissions,
    dashboard_not_found,
    dashboard_access_denied,
    internal_failure,
    widget_id_not_found,

    pub const json_field_names = .{
        .data_source_access_denied = "DATA_SOURCE_ACCESS_DENIED",
        .execution_role_assume_failed = "EXECUTION_ROLE_ASSUME_FAILED",
        .execution_role_insufficient_permissions = "EXECUTION_ROLE_INSUFFICIENT_PERMISSIONS",
        .dashboard_not_found = "DASHBOARD_NOT_FOUND",
        .dashboard_access_denied = "DASHBOARD_ACCESS_DENIED",
        .internal_failure = "INTERNAL_FAILURE",
        .widget_id_not_found = "WIDGET_ID_NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_source_access_denied => "DATA_SOURCE_ACCESS_DENIED",
            .execution_role_assume_failed => "EXECUTION_ROLE_ASSUME_FAILED",
            .execution_role_insufficient_permissions => "EXECUTION_ROLE_INSUFFICIENT_PERMISSIONS",
            .dashboard_not_found => "DASHBOARD_NOT_FOUND",
            .dashboard_access_denied => "DASHBOARD_ACCESS_DENIED",
            .internal_failure => "INTERNAL_FAILURE",
            .widget_id_not_found => "WIDGET_ID_NOT_FOUND",
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
