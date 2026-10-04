const std = @import("std");

pub const PrincipalType = enum {
    iam_role,
    iam_user,

    pub const json_field_names = .{
        .iam_role = "IAM_ROLE",
        .iam_user = "IAM_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam_role => "IAM_ROLE",
            .iam_user => "IAM_USER",
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
