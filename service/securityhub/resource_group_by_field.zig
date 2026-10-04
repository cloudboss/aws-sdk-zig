const std = @import("std");

pub const ResourceGroupByField = enum {
    account_id,
    account_name,
    region,
    resource_provider,
    resource_owner_account_id,
    resource_owner_org_id,
    resource_cloud_partition,
    resource_region,
    resource_category,
    resource_type,
    resource_name,
    finding_type,
    resource_sub_category,
    discovery_type,
    host_resource_type,
    canonical_id,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_name = "AccountName",
        .region = "Region",
        .resource_provider = "ResourceProvider",
        .resource_owner_account_id = "ResourceOwnerAccountId",
        .resource_owner_org_id = "ResourceOwnerOrgId",
        .resource_cloud_partition = "ResourceCloudPartition",
        .resource_region = "ResourceRegion",
        .resource_category = "ResourceCategory",
        .resource_type = "ResourceType",
        .resource_name = "ResourceName",
        .finding_type = "FindingsSummary.FindingType",
        .resource_sub_category = "ResourceSubCategory",
        .discovery_type = "DiscoveryType",
        .host_resource_type = "ResourceInfo.AIDetails.HostResourceType",
        .canonical_id = "ResourceInfo.AIDetails.CanonicalId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "AccountId",
            .account_name => "AccountName",
            .region => "Region",
            .resource_provider => "ResourceProvider",
            .resource_owner_account_id => "ResourceOwnerAccountId",
            .resource_owner_org_id => "ResourceOwnerOrgId",
            .resource_cloud_partition => "ResourceCloudPartition",
            .resource_region => "ResourceRegion",
            .resource_category => "ResourceCategory",
            .resource_type => "ResourceType",
            .resource_name => "ResourceName",
            .finding_type => "FindingsSummary.FindingType",
            .resource_sub_category => "ResourceSubCategory",
            .discovery_type => "DiscoveryType",
            .host_resource_type => "ResourceInfo.AIDetails.HostResourceType",
            .canonical_id => "ResourceInfo.AIDetails.CanonicalId",
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
