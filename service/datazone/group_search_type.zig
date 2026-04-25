const std = @import("std");

pub const GroupSearchType = enum {
    sso_group,
    datazone_sso_group,
    iam_role_session_group,

    pub const json_field_names = .{
        .sso_group = "SSO_GROUP",
        .datazone_sso_group = "DATAZONE_SSO_GROUP",
        .iam_role_session_group = "IAM_ROLE_SESSION_GROUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sso_group => "SSO_GROUP",
            .datazone_sso_group => "DATAZONE_SSO_GROUP",
            .iam_role_session_group => "IAM_ROLE_SESSION_GROUP",
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
