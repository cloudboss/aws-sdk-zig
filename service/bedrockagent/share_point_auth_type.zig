const std = @import("std");

pub const SharePointAuthType = enum {
    oauth2_client_credentials,
    oauth2_sharepoint_app_only_client_credentials,

    pub const json_field_names = .{
        .oauth2_client_credentials = "OAUTH2_CLIENT_CREDENTIALS",
        .oauth2_sharepoint_app_only_client_credentials = "OAUTH2_SHAREPOINT_APP_ONLY_CLIENT_CREDENTIALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .oauth2_client_credentials => "OAUTH2_CLIENT_CREDENTIALS",
            .oauth2_sharepoint_app_only_client_credentials => "OAUTH2_SHAREPOINT_APP_ONLY_CLIENT_CREDENTIALS",
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
