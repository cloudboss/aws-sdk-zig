const aws = @import("aws");

const Tag = @import("tag.zig").Tag;

/// Describes a network resource.
pub const NetworkResource = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8,

    /// The Amazon Web Services Region.
    aws_region: ?[]const u8,

    /// The ID of a core network.
    core_network_id: ?[]const u8,

    /// Information about the resource, in JSON format. Network Manager gets this
    /// information by describing the resource using its Describe API call.
    definition: ?[]const u8,

    /// The time that the resource definition was retrieved.
    definition_timestamp: ?i64,

    /// The resource metadata.
    metadata: ?[]const aws.map.StringMapEntry,

    /// The ARN of the gateway.
    registered_gateway_arn: ?[]const u8,

    /// The ARN of the resource.
    resource_arn: ?[]const u8,

    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The resource type.
    ///
    /// The following are the supported resource types for Direct Connect:
    ///
    /// * `dxcon`
    ///
    /// * `dx-gateway`
    ///
    /// * `dx-vif`
    ///
    /// The following are the supported resource types for Network Manager:
    ///
    /// * `attachment`
    ///
    /// * `connect-peer`
    ///
    /// * `connection`
    ///
    /// * `core-network`
    ///
    /// * `device`
    ///
    /// * `link`
    ///
    /// * `peering`
    ///
    /// * `site`
    ///
    /// The following are the supported resource types for Amazon VPC:
    ///
    /// * `customer-gateway`
    ///
    /// * `transit-gateway`
    ///
    /// * `transit-gateway-attachment`
    ///
    /// * `transit-gateway-connect-peer`
    ///
    /// * `transit-gateway-route-table`
    ///
    /// * `vpn-connection`
    resource_type: ?[]const u8,

    /// The tags.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
        .core_network_id = "CoreNetworkId",
        .definition = "Definition",
        .definition_timestamp = "DefinitionTimestamp",
        .metadata = "Metadata",
        .registered_gateway_arn = "RegisteredGatewayArn",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};
