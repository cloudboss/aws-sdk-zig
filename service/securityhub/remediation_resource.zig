const CloudProviderName = @import("cloud_provider_name.zig").CloudProviderName;

/// Provides comprehensive details about a resource.
pub const RemediationResource = struct {
    /// The Amazon Web Services account that recorded the resource data in Security
    /// Hub.
    account_id: []const u8,

    /// The cloud provider where the resource exists.
    ///
    /// * `AWS` specifies that the resource exists in Amazon Web Services.
    ///
    /// * `Azure` specifies that the resource exists in Microsoft Azure.
    cloud_provider: CloudProviderName,

    /// The unique identifier for a resource.
    id: []const u8,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The Amazon Web Services Region in which Security Hub recorded the resource
    /// data.
    region: []const u8,

    /// The global identifier used to identify a resource.
    resource_guid: ?[]const u8 = null,

    /// The identifier of the cloud account that owns the resource. For Amazon Web
    /// Services resources, this is the Amazon Web Services account ID. For Azure
    /// resources, this is the Azure subscription ID.
    resource_owner_account_id: ?[]const u8 = null,

    /// The identifier of the cloud organization that owns the resource. For Amazon
    /// Web Services resources, this is the Organizations ID. For Azure resources,
    /// this is the Azure tenant ID.
    resource_owner_org_id: ?[]const u8 = null,

    /// The native cloud region where the resource is located. For Amazon Web
    /// Services, this is an Amazon Web Services Region (for example, `us-east-1`).
    /// For Azure resources, this is the Azure region (for example, `westus2`). This
    /// field is always included.
    resource_region: []const u8,

    /// The type of the resource.
    @"type": []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .cloud_provider = "CloudProvider",
        .id = "Id",
        .name = "Name",
        .region = "Region",
        .resource_guid = "ResourceGuid",
        .resource_owner_account_id = "ResourceOwnerAccountId",
        .resource_owner_org_id = "ResourceOwnerOrgId",
        .resource_region = "ResourceRegion",
        .@"type" = "Type",
    };
};
