const std = @import("std");

pub const FindingType = enum {
    external_access,
    unused_iam_role,
    unused_iam_user_access_key,
    unused_iam_user_password,
    unused_permission,
    internal_access,

    pub const json_field_names = .{
        .external_access = "ExternalAccess",
        .unused_iam_role = "UnusedIAMRole",
        .unused_iam_user_access_key = "UnusedIAMUserAccessKey",
        .unused_iam_user_password = "UnusedIAMUserPassword",
        .unused_permission = "UnusedPermission",
        .internal_access = "InternalAccess",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .external_access => "ExternalAccess",
            .unused_iam_role => "UnusedIAMRole",
            .unused_iam_user_access_key => "UnusedIAMUserAccessKey",
            .unused_iam_user_password => "UnusedIAMUserPassword",
            .unused_permission => "UnusedPermission",
            .internal_access => "InternalAccess",
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
