const std = @import("std");

pub const AssetBundleExportJobDataSetPropertyToOverride = enum {
    name,
    refresh_failure_email_alert_status,

    pub const json_field_names = .{
        .name = "Name",
        .refresh_failure_email_alert_status = "RefreshFailureEmailAlertStatus",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .refresh_failure_email_alert_status => "RefreshFailureEmailAlertStatus",
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
