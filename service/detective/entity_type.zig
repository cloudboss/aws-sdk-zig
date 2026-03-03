const std = @import("std");

pub const EntityType = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
