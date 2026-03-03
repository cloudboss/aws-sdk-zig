const std = @import("std");

pub const ResourceType = enum {
    group,
    user,
    identity_store,
    group_membership,
    resource_policy,

    pub const json_field_names = .{
        .group = "GROUP",
        .user = "USER",
        .identity_store = "IDENTITY_STORE",
        .group_membership = "GROUP_MEMBERSHIP",
        .resource_policy = "RESOURCE_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .group => "GROUP",
            .user => "USER",
            .identity_store => "IDENTITY_STORE",
            .group_membership => "GROUP_MEMBERSHIP",
            .resource_policy => "RESOURCE_POLICY",
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
