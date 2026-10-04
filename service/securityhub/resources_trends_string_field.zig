const std = @import("std");

pub const ResourcesTrendsStringField = enum {
    account_id,
    region,
    resource_type,
    resource_category,
    resource_cloud_provider,
    resource_region,
    resource_owner_id,
    resource_owner_organization_id,

    pub const json_field_names = .{
        .account_id = "account_id",
        .region = "region",
        .resource_type = "resource_type",
        .resource_category = "resource_category",
        .resource_cloud_provider = "resource_cloud_provider",
        .resource_region = "resource_region",
        .resource_owner_id = "resource_owner_id",
        .resource_owner_organization_id = "resource_owner_organization_id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "account_id",
            .region => "region",
            .resource_type => "resource_type",
            .resource_category => "resource_category",
            .resource_cloud_provider => "resource_cloud_provider",
            .resource_region => "resource_region",
            .resource_owner_id => "resource_owner_id",
            .resource_owner_organization_id => "resource_owner_organization_id",
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
