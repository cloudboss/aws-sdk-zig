const std = @import("std");

pub const PolicyIdentifierPolicyType = enum {
    @"inline",
    aws_managed,
    user_managed,
    permission_boundary,
    scp,
    rcp,

    pub const json_field_names = .{
        .@"inline" = "inline",
        .aws_managed = "aws-managed",
        .user_managed = "user-managed",
        .permission_boundary = "permission-boundary",
        .scp = "scp",
        .rcp = "rcp",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"inline" => "inline",
            .aws_managed => "aws-managed",
            .user_managed => "user-managed",
            .permission_boundary => "permission-boundary",
            .scp => "scp",
            .rcp => "rcp",
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
