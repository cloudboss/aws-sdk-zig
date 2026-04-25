const std = @import("std");

pub const UserType = enum {
    iam_user,
    iam_role,
    sso_user,
    iam_role_session,

    pub const json_field_names = .{
        .iam_user = "IAM_USER",
        .iam_role = "IAM_ROLE",
        .sso_user = "SSO_USER",
        .iam_role_session = "IAM_ROLE_SESSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam_user => "IAM_USER",
            .iam_role => "IAM_ROLE",
            .sso_user => "SSO_USER",
            .iam_role_session => "IAM_ROLE_SESSION",
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
