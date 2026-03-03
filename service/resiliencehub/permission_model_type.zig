const std = @import("std");

pub const PermissionModelType = enum {
    legacy_iam_user,
    role_based,

    pub const json_field_names = .{
        .legacy_iam_user = "LegacyIAMUser",
        .role_based = "RoleBased",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .legacy_iam_user => "LegacyIAMUser",
            .role_based => "RoleBased",
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
