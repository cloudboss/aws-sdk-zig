const aws = @import("aws");
const std = @import("std");

const accept_attachment = @import("accept_attachment.zig");
const associate_connect_peer = @import("associate_connect_peer.zig");
const associate_customer_gateway = @import("associate_customer_gateway.zig");
const associate_link = @import("associate_link.zig");
const associate_transit_gateway_connect_peer = @import("associate_transit_gateway_connect_peer.zig");
const create_connect_attachment = @import("create_connect_attachment.zig");
const create_connect_peer = @import("create_connect_peer.zig");
const create_connection = @import("create_connection.zig");
const create_core_network = @import("create_core_network.zig");
const create_core_network_prefix_list_association = @import("create_core_network_prefix_list_association.zig");
const create_device = @import("create_device.zig");
const create_direct_connect_gateway_attachment = @import("create_direct_connect_gateway_attachment.zig");
const create_global_network = @import("create_global_network.zig");
const create_link = @import("create_link.zig");
const create_site = @import("create_site.zig");
const create_site_to_site_vpn_attachment = @import("create_site_to_site_vpn_attachment.zig");
const create_transit_gateway_peering = @import("create_transit_gateway_peering.zig");
const create_transit_gateway_route_table_attachment = @import("create_transit_gateway_route_table_attachment.zig");
const create_vpc_attachment = @import("create_vpc_attachment.zig");
const delete_attachment = @import("delete_attachment.zig");
const delete_connect_peer = @import("delete_connect_peer.zig");
const delete_connection = @import("delete_connection.zig");
const delete_core_network = @import("delete_core_network.zig");
const delete_core_network_policy_version = @import("delete_core_network_policy_version.zig");
const delete_core_network_prefix_list_association = @import("delete_core_network_prefix_list_association.zig");
const delete_device = @import("delete_device.zig");
const delete_global_network = @import("delete_global_network.zig");
const delete_link = @import("delete_link.zig");
const delete_peering = @import("delete_peering.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_site = @import("delete_site.zig");
const deregister_transit_gateway = @import("deregister_transit_gateway.zig");
const describe_global_networks = @import("describe_global_networks.zig");
const disassociate_connect_peer = @import("disassociate_connect_peer.zig");
const disassociate_customer_gateway = @import("disassociate_customer_gateway.zig");
const disassociate_link = @import("disassociate_link.zig");
const disassociate_transit_gateway_connect_peer = @import("disassociate_transit_gateway_connect_peer.zig");
const execute_core_network_change_set = @import("execute_core_network_change_set.zig");
const get_connect_attachment = @import("get_connect_attachment.zig");
const get_connect_peer = @import("get_connect_peer.zig");
const get_connect_peer_associations = @import("get_connect_peer_associations.zig");
const get_connections = @import("get_connections.zig");
const get_core_network = @import("get_core_network.zig");
const get_core_network_change_events = @import("get_core_network_change_events.zig");
const get_core_network_change_set = @import("get_core_network_change_set.zig");
const get_core_network_policy = @import("get_core_network_policy.zig");
const get_customer_gateway_associations = @import("get_customer_gateway_associations.zig");
const get_devices = @import("get_devices.zig");
const get_direct_connect_gateway_attachment = @import("get_direct_connect_gateway_attachment.zig");
const get_link_associations = @import("get_link_associations.zig");
const get_links = @import("get_links.zig");
const get_network_resource_counts = @import("get_network_resource_counts.zig");
const get_network_resource_relationships = @import("get_network_resource_relationships.zig");
const get_network_resources = @import("get_network_resources.zig");
const get_network_routes = @import("get_network_routes.zig");
const get_network_telemetry = @import("get_network_telemetry.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_route_analysis = @import("get_route_analysis.zig");
const get_site_to_site_vpn_attachment = @import("get_site_to_site_vpn_attachment.zig");
const get_sites = @import("get_sites.zig");
const get_transit_gateway_connect_peer_associations = @import("get_transit_gateway_connect_peer_associations.zig");
const get_transit_gateway_peering = @import("get_transit_gateway_peering.zig");
const get_transit_gateway_registrations = @import("get_transit_gateway_registrations.zig");
const get_transit_gateway_route_table_attachment = @import("get_transit_gateway_route_table_attachment.zig");
const get_vpc_attachment = @import("get_vpc_attachment.zig");
const list_attachment_routing_policy_associations = @import("list_attachment_routing_policy_associations.zig");
const list_attachments = @import("list_attachments.zig");
const list_connect_peers = @import("list_connect_peers.zig");
const list_core_network_policy_versions = @import("list_core_network_policy_versions.zig");
const list_core_network_prefix_list_associations = @import("list_core_network_prefix_list_associations.zig");
const list_core_network_routing_information = @import("list_core_network_routing_information.zig");
const list_core_networks = @import("list_core_networks.zig");
const list_organization_service_access_status = @import("list_organization_service_access_status.zig");
const list_peerings = @import("list_peerings.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_attachment_routing_policy_label = @import("put_attachment_routing_policy_label.zig");
const put_core_network_policy = @import("put_core_network_policy.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const register_transit_gateway = @import("register_transit_gateway.zig");
const reject_attachment = @import("reject_attachment.zig");
const remove_attachment_routing_policy_label = @import("remove_attachment_routing_policy_label.zig");
const restore_core_network_policy_version = @import("restore_core_network_policy_version.zig");
const start_organization_service_access_update = @import("start_organization_service_access_update.zig");
const start_route_analysis = @import("start_route_analysis.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connection = @import("update_connection.zig");
const update_core_network = @import("update_core_network.zig");
const update_device = @import("update_device.zig");
const update_direct_connect_gateway_attachment = @import("update_direct_connect_gateway_attachment.zig");
const update_global_network = @import("update_global_network.zig");
const update_link = @import("update_link.zig");
const update_network_resource_metadata = @import("update_network_resource_metadata.zig");
const update_site = @import("update_site.zig");
const update_vpc_attachment = @import("update_vpc_attachment.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "NetworkManager";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Accepts a core network attachment request.
    ///
    /// Once the attachment request is accepted by a core network owner, the
    /// attachment is
    /// created and connected to a core network.
    pub fn acceptAttachment(self: *Self, allocator: std.mem.Allocator, input: accept_attachment.AcceptAttachmentInput, options: accept_attachment.Options) !accept_attachment.AcceptAttachmentOutput {
        return accept_attachment.execute(self, allocator, input, options);
    }

    /// Associates a core network Connect peer with a device and optionally, with a
    /// link.
    ///
    /// If you specify a link, it must be associated with the specified device. You
    /// can only
    /// associate core network Connect peers that have been created on a core
    /// network Connect
    /// attachment on a core network.
    pub fn associateConnectPeer(self: *Self, allocator: std.mem.Allocator, input: associate_connect_peer.AssociateConnectPeerInput, options: associate_connect_peer.Options) !associate_connect_peer.AssociateConnectPeerOutput {
        return associate_connect_peer.execute(self, allocator, input, options);
    }

    /// Associates a customer gateway with a device and optionally, with a link. If
    /// you
    /// specify a link, it must be associated with the specified device.
    ///
    /// You can only associate customer gateways that are connected to a VPN
    /// attachment on a
    /// transit gateway or core network registered in your global network. When you
    /// register a
    /// transit gateway or core network, customer gateways that are connected to the
    /// transit
    /// gateway are automatically included in the global network. To list customer
    /// gateways
    /// that are connected to a transit gateway, use the
    /// [DescribeVpnConnections](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpnConnections.html) EC2 API and filter by
    /// `transit-gateway-id`.
    ///
    /// You cannot associate a customer gateway with more than one device and link.
    pub fn associateCustomerGateway(self: *Self, allocator: std.mem.Allocator, input: associate_customer_gateway.AssociateCustomerGatewayInput, options: associate_customer_gateway.Options) !associate_customer_gateway.AssociateCustomerGatewayOutput {
        return associate_customer_gateway.execute(self, allocator, input, options);
    }

    /// Associates a link to a device. A device can be associated to multiple links
    /// and a link can be associated to multiple devices. The device and link must
    /// be in the same global network and the same site.
    pub fn associateLink(self: *Self, allocator: std.mem.Allocator, input: associate_link.AssociateLinkInput, options: associate_link.Options) !associate_link.AssociateLinkOutput {
        return associate_link.execute(self, allocator, input, options);
    }

    /// Associates a transit gateway Connect peer with a device, and optionally,
    /// with a link. If you
    /// specify a link, it must be associated with the specified device.
    ///
    /// You can only associate transit gateway Connect peers that have been created
    /// on a
    /// transit gateway that's registered in your global network.
    ///
    /// You cannot associate a transit gateway Connect peer with more than one
    /// device and link.
    pub fn associateTransitGatewayConnectPeer(self: *Self, allocator: std.mem.Allocator, input: associate_transit_gateway_connect_peer.AssociateTransitGatewayConnectPeerInput, options: associate_transit_gateway_connect_peer.Options) !associate_transit_gateway_connect_peer.AssociateTransitGatewayConnectPeerOutput {
        return associate_transit_gateway_connect_peer.execute(self, allocator, input, options);
    }

    /// Creates a core network Connect attachment from a specified core network
    /// attachment.
    ///
    /// A core network Connect attachment is a GRE-based tunnel attachment that you
    /// can use to
    /// establish a connection between a core network and an appliance. A core
    /// network Connect
    /// attachment uses an existing VPC attachment as the underlying transport
    /// mechanism.
    pub fn createConnectAttachment(self: *Self, allocator: std.mem.Allocator, input: create_connect_attachment.CreateConnectAttachmentInput, options: create_connect_attachment.Options) !create_connect_attachment.CreateConnectAttachmentOutput {
        return create_connect_attachment.execute(self, allocator, input, options);
    }

    /// Creates a core network Connect peer for a specified core network connect
    /// attachment between a core network and an appliance.
    /// The peer address and transit gateway address must be the same IP address
    /// family (IPv4 or IPv6).
    pub fn createConnectPeer(self: *Self, allocator: std.mem.Allocator, input: create_connect_peer.CreateConnectPeerInput, options: create_connect_peer.Options) !create_connect_peer.CreateConnectPeerOutput {
        return create_connect_peer.execute(self, allocator, input, options);
    }

    /// Creates a connection between two devices. The devices can be a physical or
    /// virtual appliance that connects to a third-party appliance in a VPC, or a
    /// physical appliance that connects to another physical appliance in an
    /// on-premises network.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: create_connection.Options) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Creates a core network as part of your global network, and optionally, with
    /// a core network policy.
    pub fn createCoreNetwork(self: *Self, allocator: std.mem.Allocator, input: create_core_network.CreateCoreNetworkInput, options: create_core_network.Options) !create_core_network.CreateCoreNetworkOutput {
        return create_core_network.execute(self, allocator, input, options);
    }

    /// Creates an association between a core network and a prefix list for routing
    /// control.
    pub fn createCoreNetworkPrefixListAssociation(self: *Self, allocator: std.mem.Allocator, input: create_core_network_prefix_list_association.CreateCoreNetworkPrefixListAssociationInput, options: create_core_network_prefix_list_association.Options) !create_core_network_prefix_list_association.CreateCoreNetworkPrefixListAssociationOutput {
        return create_core_network_prefix_list_association.execute(self, allocator, input, options);
    }

    /// Creates a new device in a global network. If you specify both a site ID and
    /// a
    /// location, the location of the site is used for visualization in the Network
    /// Manager console.
    pub fn createDevice(self: *Self, allocator: std.mem.Allocator, input: create_device.CreateDeviceInput, options: create_device.Options) !create_device.CreateDeviceOutput {
        return create_device.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services Direct Connect gateway attachment
    pub fn createDirectConnectGatewayAttachment(self: *Self, allocator: std.mem.Allocator, input: create_direct_connect_gateway_attachment.CreateDirectConnectGatewayAttachmentInput, options: create_direct_connect_gateway_attachment.Options) !create_direct_connect_gateway_attachment.CreateDirectConnectGatewayAttachmentOutput {
        return create_direct_connect_gateway_attachment.execute(self, allocator, input, options);
    }

    /// Creates a new, empty global network.
    pub fn createGlobalNetwork(self: *Self, allocator: std.mem.Allocator, input: create_global_network.CreateGlobalNetworkInput, options: create_global_network.Options) !create_global_network.CreateGlobalNetworkOutput {
        return create_global_network.execute(self, allocator, input, options);
    }

    /// Creates a new link for a specified site.
    pub fn createLink(self: *Self, allocator: std.mem.Allocator, input: create_link.CreateLinkInput, options: create_link.Options) !create_link.CreateLinkOutput {
        return create_link.execute(self, allocator, input, options);
    }

    /// Creates a new site in a global network.
    pub fn createSite(self: *Self, allocator: std.mem.Allocator, input: create_site.CreateSiteInput, options: create_site.Options) !create_site.CreateSiteOutput {
        return create_site.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services site-to-site VPN attachment on an edge
    /// location of a core network.
    pub fn createSiteToSiteVpnAttachment(self: *Self, allocator: std.mem.Allocator, input: create_site_to_site_vpn_attachment.CreateSiteToSiteVpnAttachmentInput, options: create_site_to_site_vpn_attachment.Options) !create_site_to_site_vpn_attachment.CreateSiteToSiteVpnAttachmentOutput {
        return create_site_to_site_vpn_attachment.execute(self, allocator, input, options);
    }

    /// Creates a transit gateway peering connection.
    pub fn createTransitGatewayPeering(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_peering.CreateTransitGatewayPeeringInput, options: create_transit_gateway_peering.Options) !create_transit_gateway_peering.CreateTransitGatewayPeeringOutput {
        return create_transit_gateway_peering.execute(self, allocator, input, options);
    }

    /// Creates a transit gateway route table attachment.
    pub fn createTransitGatewayRouteTableAttachment(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_route_table_attachment.CreateTransitGatewayRouteTableAttachmentInput, options: create_transit_gateway_route_table_attachment.Options) !create_transit_gateway_route_table_attachment.CreateTransitGatewayRouteTableAttachmentOutput {
        return create_transit_gateway_route_table_attachment.execute(self, allocator, input, options);
    }

    /// Creates a VPC attachment on an edge location of a core network.
    pub fn createVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: create_vpc_attachment.CreateVpcAttachmentInput, options: create_vpc_attachment.Options) !create_vpc_attachment.CreateVpcAttachmentOutput {
        return create_vpc_attachment.execute(self, allocator, input, options);
    }

    /// Deletes an attachment. Supports all attachment types.
    pub fn deleteAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_attachment.DeleteAttachmentInput, options: delete_attachment.Options) !delete_attachment.DeleteAttachmentOutput {
        return delete_attachment.execute(self, allocator, input, options);
    }

    /// Deletes a Connect peer.
    pub fn deleteConnectPeer(self: *Self, allocator: std.mem.Allocator, input: delete_connect_peer.DeleteConnectPeerInput, options: delete_connect_peer.Options) !delete_connect_peer.DeleteConnectPeerOutput {
        return delete_connect_peer.execute(self, allocator, input, options);
    }

    /// Deletes the specified connection in your global network.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes a core network along with all core network policies. This can only
    /// be done if there are no attachments on a core network.
    pub fn deleteCoreNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_core_network.DeleteCoreNetworkInput, options: delete_core_network.Options) !delete_core_network.DeleteCoreNetworkOutput {
        return delete_core_network.execute(self, allocator, input, options);
    }

    /// Deletes a policy version from a core network. You can't delete the current
    /// LIVE policy.
    pub fn deleteCoreNetworkPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: delete_core_network_policy_version.DeleteCoreNetworkPolicyVersionInput, options: delete_core_network_policy_version.Options) !delete_core_network_policy_version.DeleteCoreNetworkPolicyVersionOutput {
        return delete_core_network_policy_version.execute(self, allocator, input, options);
    }

    /// Deletes an association between a core network and a prefix list.
    pub fn deleteCoreNetworkPrefixListAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_core_network_prefix_list_association.DeleteCoreNetworkPrefixListAssociationInput, options: delete_core_network_prefix_list_association.Options) !delete_core_network_prefix_list_association.DeleteCoreNetworkPrefixListAssociationOutput {
        return delete_core_network_prefix_list_association.execute(self, allocator, input, options);
    }

    /// Deletes an existing device. You must first disassociate the device from any
    /// links and
    /// customer gateways.
    pub fn deleteDevice(self: *Self, allocator: std.mem.Allocator, input: delete_device.DeleteDeviceInput, options: delete_device.Options) !delete_device.DeleteDeviceOutput {
        return delete_device.execute(self, allocator, input, options);
    }

    /// Deletes an existing global network. You must first delete all global network
    /// objects
    /// (devices, links, and sites), deregister all transit gateways, and delete any
    /// core networks.
    pub fn deleteGlobalNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_global_network.DeleteGlobalNetworkInput, options: delete_global_network.Options) !delete_global_network.DeleteGlobalNetworkOutput {
        return delete_global_network.execute(self, allocator, input, options);
    }

    /// Deletes an existing link. You must first disassociate the link from any
    /// devices and
    /// customer gateways.
    pub fn deleteLink(self: *Self, allocator: std.mem.Allocator, input: delete_link.DeleteLinkInput, options: delete_link.Options) !delete_link.DeleteLinkOutput {
        return delete_link.execute(self, allocator, input, options);
    }

    /// Deletes an existing peering connection.
    pub fn deletePeering(self: *Self, allocator: std.mem.Allocator, input: delete_peering.DeletePeeringInput, options: delete_peering.Options) !delete_peering.DeletePeeringOutput {
        return delete_peering.execute(self, allocator, input, options);
    }

    /// Deletes a resource policy for the specified resource. This revokes the
    /// access of the principals specified in the resource policy.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes an existing site. The site cannot be associated with any device or
    /// link.
    pub fn deleteSite(self: *Self, allocator: std.mem.Allocator, input: delete_site.DeleteSiteInput, options: delete_site.Options) !delete_site.DeleteSiteOutput {
        return delete_site.execute(self, allocator, input, options);
    }

    /// Deregisters a transit gateway from your global network. This action does not
    /// delete
    /// your transit gateway, or modify any of its attachments. This action removes
    /// any customer gateway associations.
    pub fn deregisterTransitGateway(self: *Self, allocator: std.mem.Allocator, input: deregister_transit_gateway.DeregisterTransitGatewayInput, options: deregister_transit_gateway.Options) !deregister_transit_gateway.DeregisterTransitGatewayOutput {
        return deregister_transit_gateway.execute(self, allocator, input, options);
    }

    /// Describes one or more global networks. By default, all global networks are
    /// described. To describe the objects in your global network, you must use the
    /// appropriate
    /// `Get*` action. For example, to list the transit gateways in your global
    /// network, use GetTransitGatewayRegistrations.
    pub fn describeGlobalNetworks(self: *Self, allocator: std.mem.Allocator, input: describe_global_networks.DescribeGlobalNetworksInput, options: describe_global_networks.Options) !describe_global_networks.DescribeGlobalNetworksOutput {
        return describe_global_networks.execute(self, allocator, input, options);
    }

    /// Disassociates a core network Connect peer from a device and a link.
    pub fn disassociateConnectPeer(self: *Self, allocator: std.mem.Allocator, input: disassociate_connect_peer.DisassociateConnectPeerInput, options: disassociate_connect_peer.Options) !disassociate_connect_peer.DisassociateConnectPeerOutput {
        return disassociate_connect_peer.execute(self, allocator, input, options);
    }

    /// Disassociates a customer gateway from a device and a link.
    pub fn disassociateCustomerGateway(self: *Self, allocator: std.mem.Allocator, input: disassociate_customer_gateway.DisassociateCustomerGatewayInput, options: disassociate_customer_gateway.Options) !disassociate_customer_gateway.DisassociateCustomerGatewayOutput {
        return disassociate_customer_gateway.execute(self, allocator, input, options);
    }

    /// Disassociates an existing device from a link. You must first disassociate
    /// any customer
    /// gateways that are associated with the link.
    pub fn disassociateLink(self: *Self, allocator: std.mem.Allocator, input: disassociate_link.DisassociateLinkInput, options: disassociate_link.Options) !disassociate_link.DisassociateLinkOutput {
        return disassociate_link.execute(self, allocator, input, options);
    }

    /// Disassociates a transit gateway Connect peer from a device and link.
    pub fn disassociateTransitGatewayConnectPeer(self: *Self, allocator: std.mem.Allocator, input: disassociate_transit_gateway_connect_peer.DisassociateTransitGatewayConnectPeerInput, options: disassociate_transit_gateway_connect_peer.Options) !disassociate_transit_gateway_connect_peer.DisassociateTransitGatewayConnectPeerOutput {
        return disassociate_transit_gateway_connect_peer.execute(self, allocator, input, options);
    }

    /// Executes a change set on your core network. Deploys changes globally based
    /// on the policy submitted..
    pub fn executeCoreNetworkChangeSet(self: *Self, allocator: std.mem.Allocator, input: execute_core_network_change_set.ExecuteCoreNetworkChangeSetInput, options: execute_core_network_change_set.Options) !execute_core_network_change_set.ExecuteCoreNetworkChangeSetOutput {
        return execute_core_network_change_set.execute(self, allocator, input, options);
    }

    /// Returns information about a core network Connect attachment.
    pub fn getConnectAttachment(self: *Self, allocator: std.mem.Allocator, input: get_connect_attachment.GetConnectAttachmentInput, options: get_connect_attachment.Options) !get_connect_attachment.GetConnectAttachmentOutput {
        return get_connect_attachment.execute(self, allocator, input, options);
    }

    /// Returns information about a core network Connect peer.
    pub fn getConnectPeer(self: *Self, allocator: std.mem.Allocator, input: get_connect_peer.GetConnectPeerInput, options: get_connect_peer.Options) !get_connect_peer.GetConnectPeerOutput {
        return get_connect_peer.execute(self, allocator, input, options);
    }

    /// Returns information about a core network Connect peer associations.
    pub fn getConnectPeerAssociations(self: *Self, allocator: std.mem.Allocator, input: get_connect_peer_associations.GetConnectPeerAssociationsInput, options: get_connect_peer_associations.Options) !get_connect_peer_associations.GetConnectPeerAssociationsOutput {
        return get_connect_peer_associations.execute(self, allocator, input, options);
    }

    /// Gets information about one or more of your connections in a global network.
    pub fn getConnections(self: *Self, allocator: std.mem.Allocator, input: get_connections.GetConnectionsInput, options: get_connections.Options) !get_connections.GetConnectionsOutput {
        return get_connections.execute(self, allocator, input, options);
    }

    /// Returns information about the LIVE policy for a core network.
    pub fn getCoreNetwork(self: *Self, allocator: std.mem.Allocator, input: get_core_network.GetCoreNetworkInput, options: get_core_network.Options) !get_core_network.GetCoreNetworkOutput {
        return get_core_network.execute(self, allocator, input, options);
    }

    /// Returns information about a core network change event.
    pub fn getCoreNetworkChangeEvents(self: *Self, allocator: std.mem.Allocator, input: get_core_network_change_events.GetCoreNetworkChangeEventsInput, options: get_core_network_change_events.Options) !get_core_network_change_events.GetCoreNetworkChangeEventsOutput {
        return get_core_network_change_events.execute(self, allocator, input, options);
    }

    /// Returns a change set between the LIVE core network policy and a submitted
    /// policy.
    pub fn getCoreNetworkChangeSet(self: *Self, allocator: std.mem.Allocator, input: get_core_network_change_set.GetCoreNetworkChangeSetInput, options: get_core_network_change_set.Options) !get_core_network_change_set.GetCoreNetworkChangeSetOutput {
        return get_core_network_change_set.execute(self, allocator, input, options);
    }

    /// Returns details about a core network policy. You can get details about your
    /// current live policy or any previous policy version.
    pub fn getCoreNetworkPolicy(self: *Self, allocator: std.mem.Allocator, input: get_core_network_policy.GetCoreNetworkPolicyInput, options: get_core_network_policy.Options) !get_core_network_policy.GetCoreNetworkPolicyOutput {
        return get_core_network_policy.execute(self, allocator, input, options);
    }

    /// Gets the association information for customer gateways that are associated
    /// with
    /// devices and links in your global network.
    pub fn getCustomerGatewayAssociations(self: *Self, allocator: std.mem.Allocator, input: get_customer_gateway_associations.GetCustomerGatewayAssociationsInput, options: get_customer_gateway_associations.Options) !get_customer_gateway_associations.GetCustomerGatewayAssociationsOutput {
        return get_customer_gateway_associations.execute(self, allocator, input, options);
    }

    /// Gets information about one or more of your devices in a global network.
    pub fn getDevices(self: *Self, allocator: std.mem.Allocator, input: get_devices.GetDevicesInput, options: get_devices.Options) !get_devices.GetDevicesOutput {
        return get_devices.execute(self, allocator, input, options);
    }

    /// Returns information about a specific Amazon Web Services Direct Connect
    /// gateway attachment.
    pub fn getDirectConnectGatewayAttachment(self: *Self, allocator: std.mem.Allocator, input: get_direct_connect_gateway_attachment.GetDirectConnectGatewayAttachmentInput, options: get_direct_connect_gateway_attachment.Options) !get_direct_connect_gateway_attachment.GetDirectConnectGatewayAttachmentOutput {
        return get_direct_connect_gateway_attachment.execute(self, allocator, input, options);
    }

    /// Gets the link associations for a device or a link. Either the device ID or
    /// the link ID
    /// must be specified.
    pub fn getLinkAssociations(self: *Self, allocator: std.mem.Allocator, input: get_link_associations.GetLinkAssociationsInput, options: get_link_associations.Options) !get_link_associations.GetLinkAssociationsOutput {
        return get_link_associations.execute(self, allocator, input, options);
    }

    /// Gets information about one or more links in a specified global network.
    ///
    /// If you specify the site ID, you cannot specify the type or provider in the
    /// same request. You can specify the type and provider in the same request.
    pub fn getLinks(self: *Self, allocator: std.mem.Allocator, input: get_links.GetLinksInput, options: get_links.Options) !get_links.GetLinksOutput {
        return get_links.execute(self, allocator, input, options);
    }

    /// Gets the count of network resources, by resource type, for the specified
    /// global network.
    pub fn getNetworkResourceCounts(self: *Self, allocator: std.mem.Allocator, input: get_network_resource_counts.GetNetworkResourceCountsInput, options: get_network_resource_counts.Options) !get_network_resource_counts.GetNetworkResourceCountsOutput {
        return get_network_resource_counts.execute(self, allocator, input, options);
    }

    /// Gets the network resource relationships for the specified global network.
    pub fn getNetworkResourceRelationships(self: *Self, allocator: std.mem.Allocator, input: get_network_resource_relationships.GetNetworkResourceRelationshipsInput, options: get_network_resource_relationships.Options) !get_network_resource_relationships.GetNetworkResourceRelationshipsOutput {
        return get_network_resource_relationships.execute(self, allocator, input, options);
    }

    /// Describes the network resources for the specified global network.
    ///
    /// The results include information from the corresponding Describe call for the
    /// resource, minus any sensitive information such as pre-shared keys.
    pub fn getNetworkResources(self: *Self, allocator: std.mem.Allocator, input: get_network_resources.GetNetworkResourcesInput, options: get_network_resources.Options) !get_network_resources.GetNetworkResourcesOutput {
        return get_network_resources.execute(self, allocator, input, options);
    }

    /// Gets the network routes of the specified global network.
    pub fn getNetworkRoutes(self: *Self, allocator: std.mem.Allocator, input: get_network_routes.GetNetworkRoutesInput, options: get_network_routes.Options) !get_network_routes.GetNetworkRoutesOutput {
        return get_network_routes.execute(self, allocator, input, options);
    }

    /// Gets the network telemetry of the specified global network.
    pub fn getNetworkTelemetry(self: *Self, allocator: std.mem.Allocator, input: get_network_telemetry.GetNetworkTelemetryInput, options: get_network_telemetry.Options) !get_network_telemetry.GetNetworkTelemetryOutput {
        return get_network_telemetry.execute(self, allocator, input, options);
    }

    /// Returns information about a resource policy.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Gets information about the specified route analysis.
    pub fn getRouteAnalysis(self: *Self, allocator: std.mem.Allocator, input: get_route_analysis.GetRouteAnalysisInput, options: get_route_analysis.Options) !get_route_analysis.GetRouteAnalysisOutput {
        return get_route_analysis.execute(self, allocator, input, options);
    }

    /// Returns information about a site-to-site VPN attachment.
    pub fn getSiteToSiteVpnAttachment(self: *Self, allocator: std.mem.Allocator, input: get_site_to_site_vpn_attachment.GetSiteToSiteVpnAttachmentInput, options: get_site_to_site_vpn_attachment.Options) !get_site_to_site_vpn_attachment.GetSiteToSiteVpnAttachmentOutput {
        return get_site_to_site_vpn_attachment.execute(self, allocator, input, options);
    }

    /// Gets information about one or more of your sites in a global network.
    pub fn getSites(self: *Self, allocator: std.mem.Allocator, input: get_sites.GetSitesInput, options: get_sites.Options) !get_sites.GetSitesOutput {
        return get_sites.execute(self, allocator, input, options);
    }

    /// Gets information about one or more of your transit gateway Connect peer
    /// associations in a global network.
    pub fn getTransitGatewayConnectPeerAssociations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_connect_peer_associations.GetTransitGatewayConnectPeerAssociationsInput, options: get_transit_gateway_connect_peer_associations.Options) !get_transit_gateway_connect_peer_associations.GetTransitGatewayConnectPeerAssociationsOutput {
        return get_transit_gateway_connect_peer_associations.execute(self, allocator, input, options);
    }

    /// Returns information about a transit gateway peer.
    pub fn getTransitGatewayPeering(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_peering.GetTransitGatewayPeeringInput, options: get_transit_gateway_peering.Options) !get_transit_gateway_peering.GetTransitGatewayPeeringOutput {
        return get_transit_gateway_peering.execute(self, allocator, input, options);
    }

    /// Gets information about the transit gateway registrations in a specified
    /// global network.
    pub fn getTransitGatewayRegistrations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_registrations.GetTransitGatewayRegistrationsInput, options: get_transit_gateway_registrations.Options) !get_transit_gateway_registrations.GetTransitGatewayRegistrationsOutput {
        return get_transit_gateway_registrations.execute(self, allocator, input, options);
    }

    /// Returns information about a transit gateway route table attachment.
    pub fn getTransitGatewayRouteTableAttachment(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_route_table_attachment.GetTransitGatewayRouteTableAttachmentInput, options: get_transit_gateway_route_table_attachment.Options) !get_transit_gateway_route_table_attachment.GetTransitGatewayRouteTableAttachmentOutput {
        return get_transit_gateway_route_table_attachment.execute(self, allocator, input, options);
    }

    /// Returns information about a VPC attachment.
    pub fn getVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: get_vpc_attachment.GetVpcAttachmentInput, options: get_vpc_attachment.Options) !get_vpc_attachment.GetVpcAttachmentOutput {
        return get_vpc_attachment.execute(self, allocator, input, options);
    }

    /// Lists the routing policy associations for attachments in a core network.
    pub fn listAttachmentRoutingPolicyAssociations(self: *Self, allocator: std.mem.Allocator, input: list_attachment_routing_policy_associations.ListAttachmentRoutingPolicyAssociationsInput, options: list_attachment_routing_policy_associations.Options) !list_attachment_routing_policy_associations.ListAttachmentRoutingPolicyAssociationsOutput {
        return list_attachment_routing_policy_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of core network attachments.
    pub fn listAttachments(self: *Self, allocator: std.mem.Allocator, input: list_attachments.ListAttachmentsInput, options: list_attachments.Options) !list_attachments.ListAttachmentsOutput {
        return list_attachments.execute(self, allocator, input, options);
    }

    /// Returns a list of core network Connect peers.
    pub fn listConnectPeers(self: *Self, allocator: std.mem.Allocator, input: list_connect_peers.ListConnectPeersInput, options: list_connect_peers.Options) !list_connect_peers.ListConnectPeersOutput {
        return list_connect_peers.execute(self, allocator, input, options);
    }

    /// Returns a list of core network policy versions.
    pub fn listCoreNetworkPolicyVersions(self: *Self, allocator: std.mem.Allocator, input: list_core_network_policy_versions.ListCoreNetworkPolicyVersionsInput, options: list_core_network_policy_versions.Options) !list_core_network_policy_versions.ListCoreNetworkPolicyVersionsOutput {
        return list_core_network_policy_versions.execute(self, allocator, input, options);
    }

    /// Lists the prefix list associations for a core network.
    pub fn listCoreNetworkPrefixListAssociations(self: *Self, allocator: std.mem.Allocator, input: list_core_network_prefix_list_associations.ListCoreNetworkPrefixListAssociationsInput, options: list_core_network_prefix_list_associations.Options) !list_core_network_prefix_list_associations.ListCoreNetworkPrefixListAssociationsOutput {
        return list_core_network_prefix_list_associations.execute(self, allocator, input, options);
    }

    /// Lists routing information for a core network, including routes and their
    /// attributes.
    pub fn listCoreNetworkRoutingInformation(self: *Self, allocator: std.mem.Allocator, input: list_core_network_routing_information.ListCoreNetworkRoutingInformationInput, options: list_core_network_routing_information.Options) !list_core_network_routing_information.ListCoreNetworkRoutingInformationOutput {
        return list_core_network_routing_information.execute(self, allocator, input, options);
    }

    /// Returns a list of owned and shared core networks.
    pub fn listCoreNetworks(self: *Self, allocator: std.mem.Allocator, input: list_core_networks.ListCoreNetworksInput, options: list_core_networks.Options) !list_core_networks.ListCoreNetworksOutput {
        return list_core_networks.execute(self, allocator, input, options);
    }

    /// Gets the status of the Service Linked Role (SLR) deployment for the accounts
    /// in a given Amazon Web Services Organization.
    pub fn listOrganizationServiceAccessStatus(self: *Self, allocator: std.mem.Allocator, input: list_organization_service_access_status.ListOrganizationServiceAccessStatusInput, options: list_organization_service_access_status.Options) !list_organization_service_access_status.ListOrganizationServiceAccessStatusOutput {
        return list_organization_service_access_status.execute(self, allocator, input, options);
    }

    /// Lists the peerings for a core network.
    pub fn listPeerings(self: *Self, allocator: std.mem.Allocator, input: list_peerings.ListPeeringsInput, options: list_peerings.Options) !list_peerings.ListPeeringsOutput {
        return list_peerings.execute(self, allocator, input, options);
    }

    /// Lists the tags for a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Applies a routing policy label to an attachment for traffic routing
    /// decisions.
    pub fn putAttachmentRoutingPolicyLabel(self: *Self, allocator: std.mem.Allocator, input: put_attachment_routing_policy_label.PutAttachmentRoutingPolicyLabelInput, options: put_attachment_routing_policy_label.Options) !put_attachment_routing_policy_label.PutAttachmentRoutingPolicyLabelOutput {
        return put_attachment_routing_policy_label.execute(self, allocator, input, options);
    }

    /// Creates a new, immutable version of a core network policy. A subsequent
    /// change set is created showing the differences between the LIVE policy and
    /// the submitted policy.
    pub fn putCoreNetworkPolicy(self: *Self, allocator: std.mem.Allocator, input: put_core_network_policy.PutCoreNetworkPolicyInput, options: put_core_network_policy.Options) !put_core_network_policy.PutCoreNetworkPolicyOutput {
        return put_core_network_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource policy.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Registers a transit gateway in your global network. Not all Regions support
    /// transit
    /// gateways for global networks. For a list of the supported Regions, see
    /// [Region
    /// Availability](https://docs.aws.amazon.com/network-manager/latest/tgwnm/what-are-global-networks.html#nm-available-regions) in the *Amazon Web Services Transit Gateways for Global
    /// Networks User Guide*. The transit gateway can be in any of the supported
    /// Amazon Web Services Regions, but it must be owned by the same Amazon Web
    /// Services account that owns the global
    /// network. You cannot register a transit gateway in more than one global
    /// network.
    pub fn registerTransitGateway(self: *Self, allocator: std.mem.Allocator, input: register_transit_gateway.RegisterTransitGatewayInput, options: register_transit_gateway.Options) !register_transit_gateway.RegisterTransitGatewayOutput {
        return register_transit_gateway.execute(self, allocator, input, options);
    }

    /// Rejects a core network attachment request.
    pub fn rejectAttachment(self: *Self, allocator: std.mem.Allocator, input: reject_attachment.RejectAttachmentInput, options: reject_attachment.Options) !reject_attachment.RejectAttachmentOutput {
        return reject_attachment.execute(self, allocator, input, options);
    }

    /// Removes a routing policy label from an attachment.
    pub fn removeAttachmentRoutingPolicyLabel(self: *Self, allocator: std.mem.Allocator, input: remove_attachment_routing_policy_label.RemoveAttachmentRoutingPolicyLabelInput, options: remove_attachment_routing_policy_label.Options) !remove_attachment_routing_policy_label.RemoveAttachmentRoutingPolicyLabelOutput {
        return remove_attachment_routing_policy_label.execute(self, allocator, input, options);
    }

    /// Restores a previous policy version as a new, immutable version of a core
    /// network policy. A subsequent change set is created showing the differences
    /// between the LIVE policy and restored policy.
    pub fn restoreCoreNetworkPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: restore_core_network_policy_version.RestoreCoreNetworkPolicyVersionInput, options: restore_core_network_policy_version.Options) !restore_core_network_policy_version.RestoreCoreNetworkPolicyVersionOutput {
        return restore_core_network_policy_version.execute(self, allocator, input, options);
    }

    /// Enables the Network Manager service for an Amazon Web Services Organization.
    /// This can only be called by a management account within the organization.
    pub fn startOrganizationServiceAccessUpdate(self: *Self, allocator: std.mem.Allocator, input: start_organization_service_access_update.StartOrganizationServiceAccessUpdateInput, options: start_organization_service_access_update.Options) !start_organization_service_access_update.StartOrganizationServiceAccessUpdateOutput {
        return start_organization_service_access_update.execute(self, allocator, input, options);
    }

    /// Starts analyzing the routing path between the specified source and
    /// destination. For more information,
    /// see [Route
    /// Analyzer](https://docs.aws.amazon.com/vpc/latest/tgw/route-analyzer.html).
    pub fn startRouteAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_route_analysis.StartRouteAnalysisInput, options: start_route_analysis.Options) !start_route_analysis.StartRouteAnalysisOutput {
        return start_route_analysis.execute(self, allocator, input, options);
    }

    /// Tags a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the information for an existing connection. To remove information
    /// for any of the parameters,
    /// specify an empty string.
    pub fn updateConnection(self: *Self, allocator: std.mem.Allocator, input: update_connection.UpdateConnectionInput, options: update_connection.Options) !update_connection.UpdateConnectionOutput {
        return update_connection.execute(self, allocator, input, options);
    }

    /// Updates the description of a core network.
    pub fn updateCoreNetwork(self: *Self, allocator: std.mem.Allocator, input: update_core_network.UpdateCoreNetworkInput, options: update_core_network.Options) !update_core_network.UpdateCoreNetworkOutput {
        return update_core_network.execute(self, allocator, input, options);
    }

    /// Updates the details for an existing device. To remove information for any of
    /// the
    /// parameters, specify an empty string.
    pub fn updateDevice(self: *Self, allocator: std.mem.Allocator, input: update_device.UpdateDeviceInput, options: update_device.Options) !update_device.UpdateDeviceOutput {
        return update_device.execute(self, allocator, input, options);
    }

    /// Updates the edge locations associated with an Amazon Web Services Direct
    /// Connect gateway attachment.
    pub fn updateDirectConnectGatewayAttachment(self: *Self, allocator: std.mem.Allocator, input: update_direct_connect_gateway_attachment.UpdateDirectConnectGatewayAttachmentInput, options: update_direct_connect_gateway_attachment.Options) !update_direct_connect_gateway_attachment.UpdateDirectConnectGatewayAttachmentOutput {
        return update_direct_connect_gateway_attachment.execute(self, allocator, input, options);
    }

    /// Updates an existing global network. To remove information for any of the
    /// parameters,
    /// specify an empty string.
    pub fn updateGlobalNetwork(self: *Self, allocator: std.mem.Allocator, input: update_global_network.UpdateGlobalNetworkInput, options: update_global_network.Options) !update_global_network.UpdateGlobalNetworkOutput {
        return update_global_network.execute(self, allocator, input, options);
    }

    /// Updates the details for an existing link. To remove information for any of
    /// the
    /// parameters, specify an empty string.
    pub fn updateLink(self: *Self, allocator: std.mem.Allocator, input: update_link.UpdateLinkInput, options: update_link.Options) !update_link.UpdateLinkOutput {
        return update_link.execute(self, allocator, input, options);
    }

    /// Updates the resource metadata for the specified global network.
    pub fn updateNetworkResourceMetadata(self: *Self, allocator: std.mem.Allocator, input: update_network_resource_metadata.UpdateNetworkResourceMetadataInput, options: update_network_resource_metadata.Options) !update_network_resource_metadata.UpdateNetworkResourceMetadataOutput {
        return update_network_resource_metadata.execute(self, allocator, input, options);
    }

    /// Updates the information for an existing site. To remove information for any
    /// of the
    /// parameters, specify an empty string.
    pub fn updateSite(self: *Self, allocator: std.mem.Allocator, input: update_site.UpdateSiteInput, options: update_site.Options) !update_site.UpdateSiteOutput {
        return update_site.execute(self, allocator, input, options);
    }

    /// Updates a VPC attachment.
    pub fn updateVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: update_vpc_attachment.UpdateVpcAttachmentInput, options: update_vpc_attachment.Options) !update_vpc_attachment.UpdateVpcAttachmentOutput {
        return update_vpc_attachment.execute(self, allocator, input, options);
    }

    pub fn describeGlobalNetworksPaginator(self: *Self, params: describe_global_networks.DescribeGlobalNetworksInput) paginator.DescribeGlobalNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getConnectPeerAssociationsPaginator(self: *Self, params: get_connect_peer_associations.GetConnectPeerAssociationsInput) paginator.GetConnectPeerAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getConnectionsPaginator(self: *Self, params: get_connections.GetConnectionsInput) paginator.GetConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCoreNetworkChangeEventsPaginator(self: *Self, params: get_core_network_change_events.GetCoreNetworkChangeEventsInput) paginator.GetCoreNetworkChangeEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCoreNetworkChangeSetPaginator(self: *Self, params: get_core_network_change_set.GetCoreNetworkChangeSetInput) paginator.GetCoreNetworkChangeSetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCustomerGatewayAssociationsPaginator(self: *Self, params: get_customer_gateway_associations.GetCustomerGatewayAssociationsInput) paginator.GetCustomerGatewayAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDevicesPaginator(self: *Self, params: get_devices.GetDevicesInput) paginator.GetDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getLinkAssociationsPaginator(self: *Self, params: get_link_associations.GetLinkAssociationsInput) paginator.GetLinkAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getLinksPaginator(self: *Self, params: get_links.GetLinksInput) paginator.GetLinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getNetworkResourceCountsPaginator(self: *Self, params: get_network_resource_counts.GetNetworkResourceCountsInput) paginator.GetNetworkResourceCountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getNetworkResourceRelationshipsPaginator(self: *Self, params: get_network_resource_relationships.GetNetworkResourceRelationshipsInput) paginator.GetNetworkResourceRelationshipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getNetworkResourcesPaginator(self: *Self, params: get_network_resources.GetNetworkResourcesInput) paginator.GetNetworkResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getNetworkTelemetryPaginator(self: *Self, params: get_network_telemetry.GetNetworkTelemetryInput) paginator.GetNetworkTelemetryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSitesPaginator(self: *Self, params: get_sites.GetSitesInput) paginator.GetSitesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayConnectPeerAssociationsPaginator(self: *Self, params: get_transit_gateway_connect_peer_associations.GetTransitGatewayConnectPeerAssociationsInput) paginator.GetTransitGatewayConnectPeerAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayRegistrationsPaginator(self: *Self, params: get_transit_gateway_registrations.GetTransitGatewayRegistrationsInput) paginator.GetTransitGatewayRegistrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachmentRoutingPolicyAssociationsPaginator(self: *Self, params: list_attachment_routing_policy_associations.ListAttachmentRoutingPolicyAssociationsInput) paginator.ListAttachmentRoutingPolicyAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachmentsPaginator(self: *Self, params: list_attachments.ListAttachmentsInput) paginator.ListAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectPeersPaginator(self: *Self, params: list_connect_peers.ListConnectPeersInput) paginator.ListConnectPeersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoreNetworkPolicyVersionsPaginator(self: *Self, params: list_core_network_policy_versions.ListCoreNetworkPolicyVersionsInput) paginator.ListCoreNetworkPolicyVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoreNetworkPrefixListAssociationsPaginator(self: *Self, params: list_core_network_prefix_list_associations.ListCoreNetworkPrefixListAssociationsInput) paginator.ListCoreNetworkPrefixListAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoreNetworkRoutingInformationPaginator(self: *Self, params: list_core_network_routing_information.ListCoreNetworkRoutingInformationInput) paginator.ListCoreNetworkRoutingInformationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoreNetworksPaginator(self: *Self, params: list_core_networks.ListCoreNetworksInput) paginator.ListCoreNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPeeringsPaginator(self: *Self, params: list_peerings.ListPeeringsInput) paginator.ListPeeringsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
