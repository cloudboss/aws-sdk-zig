const std = @import("std");

/// Types of users in the system
pub const UserType = enum {
    /// AWS IAM user type
    iam,
    /// AWS IAM Identity Center user type
    idc,
    /// External Identity Provider user type
    idp,

    pub const json_field_names = .{
        .iam = "IAM",
        .idc = "IDC",
        .idp = "IDP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam => "IAM",
            .idc => "IDC",
            .idp => "IDP",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
