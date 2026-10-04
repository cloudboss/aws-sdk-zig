const std = @import("std");

pub const EntityType = enum {
    user,
    role,
    group,
    local_managed_policy,
    aws_managed_policy,

    pub const json_field_names = .{
        .user = "User",
        .role = "Role",
        .group = "Group",
        .local_managed_policy = "LocalManagedPolicy",
        .aws_managed_policy = "AWSManagedPolicy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user => "User",
            .role => "Role",
            .group => "Group",
            .local_managed_policy => "LocalManagedPolicy",
            .aws_managed_policy => "AWSManagedPolicy",
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
