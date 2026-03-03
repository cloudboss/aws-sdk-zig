const std = @import("std");

pub const UserSearchType = enum {
    sso_user,
    datazone_user,
    datazone_sso_user,
    datazone_iam_user,

    pub const json_field_names = .{
        .sso_user = "SSO_USER",
        .datazone_user = "DATAZONE_USER",
        .datazone_sso_user = "DATAZONE_SSO_USER",
        .datazone_iam_user = "DATAZONE_IAM_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sso_user => "SSO_USER",
            .datazone_user => "DATAZONE_USER",
            .datazone_sso_user => "DATAZONE_SSO_USER",
            .datazone_iam_user => "DATAZONE_IAM_USER",
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
