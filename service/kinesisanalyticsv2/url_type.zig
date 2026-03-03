const std = @import("std");

pub const UrlType = enum {
    flink_dashboard_url,
    zeppelin_ui_url,

    pub const json_field_names = .{
        .flink_dashboard_url = "FLINK_DASHBOARD_URL",
        .zeppelin_ui_url = "ZEPPELIN_UI_URL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .flink_dashboard_url => "FLINK_DASHBOARD_URL",
            .zeppelin_ui_url => "ZEPPELIN_UI_URL",
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
