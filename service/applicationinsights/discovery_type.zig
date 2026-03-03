const std = @import("std");

pub const DiscoveryType = enum {
    resource_group_based,
    account_based,

    pub const json_field_names = .{
        .resource_group_based = "RESOURCE_GROUP_BASED",
        .account_based = "ACCOUNT_BASED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_group_based => "RESOURCE_GROUP_BASED",
            .account_based => "ACCOUNT_BASED",
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
