const aws = @import("aws");

const LinkAttributes = @import("link_attributes.zig").LinkAttributes;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const LinkDirection = @import("link_direction.zig").LinkDirection;
const ModuleConfiguration = @import("module_configuration.zig").ModuleConfiguration;
const LinkLogSettings = @import("link_log_settings.zig").LinkLogSettings;
const LinkStatus = @import("link_status.zig").LinkStatus;

/// Describes a link.
pub const ListLinksResponseStructure = struct {
    /// Describes attributes of a link.
    attributes: ?LinkAttributes = null,

    /// The connectivity type of the link.
    connectivity_type: ?ConnectivityType = null,

    /// The timestamp of when the link was created.
    created_at: i64,

    /// The direction of the link.
    direction: ?LinkDirection = null,

    /// Describes the configuration of flow modules.
    flow_modules: ?[]const ModuleConfiguration = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    log_settings: ?LinkLogSettings = null,

    /// The unique identifier of the peer gateway.
    peer_gateway_id: []const u8,

    /// Describes the configuration of pending flow modules.
    pending_flow_modules: ?[]const ModuleConfiguration = null,

    /// The public endpoint of the outbound link.
    public_endpoint: ?[]const u8 = null,

    /// The status of the link.
    status: LinkStatus,

    /// A map of the key-value pairs of the tag or tags to assign to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp of when the link was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .attributes = "attributes",
        .connectivity_type = "connectivityType",
        .created_at = "createdAt",
        .direction = "direction",
        .flow_modules = "flowModules",
        .gateway_id = "gatewayId",
        .link_id = "linkId",
        .log_settings = "logSettings",
        .peer_gateway_id = "peerGatewayId",
        .pending_flow_modules = "pendingFlowModules",
        .public_endpoint = "publicEndpoint",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
