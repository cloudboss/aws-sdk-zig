const std = @import("std");

pub const RemediationStringField = enum {
    resource_type,
    priority,
    status,
    resource_id,
    resource_owner_account_id,
    resource_cloud_provider,

    pub const json_field_names = .{
        .resource_type = "Resource.Type",
        .priority = "Priority",
        .status = "Status",
        .resource_id = "Resource.Id",
        .resource_owner_account_id = "Resource.ResourceOwnerAccountId",
        .resource_cloud_provider = "Resource.CloudProvider",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "Resource.Type",
            .priority => "Priority",
            .status => "Status",
            .resource_id => "Resource.Id",
            .resource_owner_account_id => "Resource.ResourceOwnerAccountId",
            .resource_cloud_provider => "Resource.CloudProvider",
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
