const aws = @import("aws");
const std = @import("std");

const accept_direct_connect_gateway_association_proposal = @import("accept_direct_connect_gateway_association_proposal.zig");
const allocate_connection_on_interconnect = @import("allocate_connection_on_interconnect.zig");
const allocate_hosted_connection = @import("allocate_hosted_connection.zig");
const allocate_private_virtual_interface = @import("allocate_private_virtual_interface.zig");
const allocate_public_virtual_interface = @import("allocate_public_virtual_interface.zig");
const allocate_transit_virtual_interface = @import("allocate_transit_virtual_interface.zig");
const associate_connection_with_lag = @import("associate_connection_with_lag.zig");
const associate_hosted_connection = @import("associate_hosted_connection.zig");
const associate_mac_sec_key = @import("associate_mac_sec_key.zig");
const associate_virtual_interface = @import("associate_virtual_interface.zig");
const confirm_connection = @import("confirm_connection.zig");
const confirm_customer_agreement = @import("confirm_customer_agreement.zig");
const confirm_private_virtual_interface = @import("confirm_private_virtual_interface.zig");
const confirm_public_virtual_interface = @import("confirm_public_virtual_interface.zig");
const confirm_transit_virtual_interface = @import("confirm_transit_virtual_interface.zig");
const create_bgp_peer = @import("create_bgp_peer.zig");
const create_connection = @import("create_connection.zig");
const create_direct_connect_gateway = @import("create_direct_connect_gateway.zig");
const create_direct_connect_gateway_association = @import("create_direct_connect_gateway_association.zig");
const create_direct_connect_gateway_association_proposal = @import("create_direct_connect_gateway_association_proposal.zig");
const create_interconnect = @import("create_interconnect.zig");
const create_lag = @import("create_lag.zig");
const create_private_virtual_interface = @import("create_private_virtual_interface.zig");
const create_public_virtual_interface = @import("create_public_virtual_interface.zig");
const create_transit_virtual_interface = @import("create_transit_virtual_interface.zig");
const delete_bgp_peer = @import("delete_bgp_peer.zig");
const delete_connection = @import("delete_connection.zig");
const delete_direct_connect_gateway = @import("delete_direct_connect_gateway.zig");
const delete_direct_connect_gateway_association = @import("delete_direct_connect_gateway_association.zig");
const delete_direct_connect_gateway_association_proposal = @import("delete_direct_connect_gateway_association_proposal.zig");
const delete_interconnect = @import("delete_interconnect.zig");
const delete_lag = @import("delete_lag.zig");
const delete_virtual_interface = @import("delete_virtual_interface.zig");
const describe_connection_loa = @import("describe_connection_loa.zig");
const describe_connections = @import("describe_connections.zig");
const describe_connections_on_interconnect = @import("describe_connections_on_interconnect.zig");
const describe_customer_metadata = @import("describe_customer_metadata.zig");
const describe_direct_connect_gateway_association_proposals = @import("describe_direct_connect_gateway_association_proposals.zig");
const describe_direct_connect_gateway_associations = @import("describe_direct_connect_gateway_associations.zig");
const describe_direct_connect_gateway_attachments = @import("describe_direct_connect_gateway_attachments.zig");
const describe_direct_connect_gateways = @import("describe_direct_connect_gateways.zig");
const describe_hosted_connections = @import("describe_hosted_connections.zig");
const describe_interconnect_loa = @import("describe_interconnect_loa.zig");
const describe_interconnects = @import("describe_interconnects.zig");
const describe_lags = @import("describe_lags.zig");
const describe_loa = @import("describe_loa.zig");
const describe_locations = @import("describe_locations.zig");
const describe_router_configuration = @import("describe_router_configuration.zig");
const describe_tags = @import("describe_tags.zig");
const describe_virtual_gateways = @import("describe_virtual_gateways.zig");
const describe_virtual_interfaces = @import("describe_virtual_interfaces.zig");
const disassociate_connection_from_lag = @import("disassociate_connection_from_lag.zig");
const disassociate_mac_sec_key = @import("disassociate_mac_sec_key.zig");
const list_virtual_interface_test_history = @import("list_virtual_interface_test_history.zig");
const start_bgp_failover_test = @import("start_bgp_failover_test.zig");
const stop_bgp_failover_test = @import("stop_bgp_failover_test.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connection = @import("update_connection.zig");
const update_direct_connect_gateway = @import("update_direct_connect_gateway.zig");
const update_direct_connect_gateway_association = @import("update_direct_connect_gateway_association.zig");
const update_lag = @import("update_lag.zig");
const update_virtual_interface_attributes = @import("update_virtual_interface_attributes.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Direct Connect";

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

    /// Accepts a proposal request to attach a virtual private gateway or transit
    /// gateway to a Direct Connect gateway.
    pub fn acceptDirectConnectGatewayAssociationProposal(self: *Self, allocator: std.mem.Allocator, input: accept_direct_connect_gateway_association_proposal.AcceptDirectConnectGatewayAssociationProposalInput, options: accept_direct_connect_gateway_association_proposal.Options) !accept_direct_connect_gateway_association_proposal.AcceptDirectConnectGatewayAssociationProposalOutput {
        return accept_direct_connect_gateway_association_proposal.execute(self, allocator, input, options);
    }

    /// Deprecated. Use AllocateHostedConnection instead.
    ///
    /// Creates a hosted connection on an interconnect.
    ///
    /// Allocates a VLAN number and a specified amount of bandwidth for use by a
    /// hosted connection on the specified interconnect.
    ///
    /// Intended for use by Direct Connect Partners only.
    pub fn allocateConnectionOnInterconnect(self: *Self, allocator: std.mem.Allocator, input: allocate_connection_on_interconnect.AllocateConnectionOnInterconnectInput, options: allocate_connection_on_interconnect.Options) !allocate_connection_on_interconnect.AllocateConnectionOnInterconnectOutput {
        return allocate_connection_on_interconnect.execute(self, allocator, input, options);
    }

    /// Creates a hosted connection on the specified interconnect or a link
    /// aggregation group (LAG) of interconnects.
    ///
    /// Allocates a VLAN number and a specified amount of capacity (bandwidth) for
    /// use by a hosted connection on the specified interconnect or LAG of
    /// interconnects.
    /// Amazon Web Services polices the hosted connection for the specified capacity
    /// and the Direct Connect Partner must also police the hosted connection for
    /// the specified capacity.
    ///
    /// Intended for use by Direct Connect Partners only.
    pub fn allocateHostedConnection(self: *Self, allocator: std.mem.Allocator, input: allocate_hosted_connection.AllocateHostedConnectionInput, options: allocate_hosted_connection.Options) !allocate_hosted_connection.AllocateHostedConnectionOutput {
        return allocate_hosted_connection.execute(self, allocator, input, options);
    }

    /// Provisions a private virtual interface to be owned by the specified Amazon
    /// Web Services account.
    ///
    /// Virtual interfaces created using this action must be confirmed by the owner
    /// using ConfirmPrivateVirtualInterface.
    /// Until then, the virtual interface is in the `Confirming` state and is not
    /// available to handle traffic.
    pub fn allocatePrivateVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: allocate_private_virtual_interface.AllocatePrivateVirtualInterfaceInput, options: allocate_private_virtual_interface.Options) !allocate_private_virtual_interface.AllocatePrivateVirtualInterfaceOutput {
        return allocate_private_virtual_interface.execute(self, allocator, input, options);
    }

    /// Provisions a public virtual interface to be owned by the specified Amazon
    /// Web Services account.
    ///
    /// The owner of a connection calls this function to provision a public virtual
    /// interface to be owned by the specified Amazon Web Services account.
    ///
    /// Virtual interfaces created using this function must be confirmed by the
    /// owner using ConfirmPublicVirtualInterface.
    /// Until this step has been completed, the virtual interface is in the
    /// `confirming` state and is not available to handle traffic.
    ///
    /// When creating an IPv6 public virtual interface, omit the Amazon address and
    /// customer address. IPv6 addresses are automatically assigned from
    /// the Amazon pool of IPv6 addresses; you cannot specify custom IPv6 addresses.
    pub fn allocatePublicVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: allocate_public_virtual_interface.AllocatePublicVirtualInterfaceInput, options: allocate_public_virtual_interface.Options) !allocate_public_virtual_interface.AllocatePublicVirtualInterfaceOutput {
        return allocate_public_virtual_interface.execute(self, allocator, input, options);
    }

    /// Provisions a transit virtual interface to be owned by the specified Amazon
    /// Web Services account. Use this type of interface to connect a transit
    /// gateway to your Direct Connect gateway.
    ///
    /// The owner of a connection provisions a transit virtual interface to be owned
    /// by the specified Amazon Web Services account.
    ///
    /// After you create a transit virtual interface, it must be confirmed by the
    /// owner using ConfirmTransitVirtualInterface. Until this step has been
    /// completed, the transit virtual interface is in the `requested` state and is
    /// not available to handle traffic.
    pub fn allocateTransitVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: allocate_transit_virtual_interface.AllocateTransitVirtualInterfaceInput, options: allocate_transit_virtual_interface.Options) !allocate_transit_virtual_interface.AllocateTransitVirtualInterfaceOutput {
        return allocate_transit_virtual_interface.execute(self, allocator, input, options);
    }

    /// Associates an existing connection with a link aggregation group (LAG). The
    /// connection
    /// is interrupted and re-established as a member of the LAG (connectivity to
    /// Amazon Web Services is
    /// interrupted). The connection must be hosted on the same Direct Connect
    /// endpoint as the LAG, and its
    /// bandwidth must match the bandwidth for the LAG. You can re-associate a
    /// connection that's
    /// currently associated with a different LAG; however, if removing the
    /// connection would cause
    /// the original LAG to fall below its setting for minimum number of operational
    /// connections,
    /// the request fails.
    ///
    /// Any virtual interfaces that are directly associated with the connection are
    /// automatically re-associated with the LAG. If the connection was originally
    /// associated
    /// with a different LAG, the virtual interfaces remain associated with the
    /// original
    /// LAG.
    ///
    /// For interconnects, any hosted connections are automatically re-associated
    /// with the
    /// LAG. If the interconnect was originally associated with a different LAG, the
    /// hosted
    /// connections remain associated with the original LAG.
    pub fn associateConnectionWithLag(self: *Self, allocator: std.mem.Allocator, input: associate_connection_with_lag.AssociateConnectionWithLagInput, options: associate_connection_with_lag.Options) !associate_connection_with_lag.AssociateConnectionWithLagOutput {
        return associate_connection_with_lag.execute(self, allocator, input, options);
    }

    /// Associates a hosted connection and its virtual interfaces with a link
    /// aggregation
    /// group (LAG) or interconnect. If the target interconnect or LAG has an
    /// existing hosted
    /// connection with a conflicting VLAN number or IP address, the operation
    /// fails. This
    /// action temporarily interrupts the hosted connection's connectivity to Amazon
    /// Web Services
    /// as it is being migrated.
    ///
    /// Intended for use by Direct Connect Partners only.
    pub fn associateHostedConnection(self: *Self, allocator: std.mem.Allocator, input: associate_hosted_connection.AssociateHostedConnectionInput, options: associate_hosted_connection.Options) !associate_hosted_connection.AssociateHostedConnectionOutput {
        return associate_hosted_connection.execute(self, allocator, input, options);
    }

    /// Associates a MAC Security (MACsec) Connection Key Name (CKN)/ Connectivity
    /// Association Key (CAK) pair with a Direct Connect connection.
    ///
    /// You must supply either the `secretARN,` or the CKN/CAK (`ckn` and `cak`)
    /// pair in the request.
    ///
    /// For information about MAC Security (MACsec) key considerations, see [MACsec
    /// pre-shared CKN/CAK key considerations
    /// ](https://docs.aws.amazon.com/directconnect/latest/UserGuide/direct-connect-mac-sec-getting-started.html#mac-sec-key-consideration) in the *Direct Connect User Guide*.
    pub fn associateMacSecKey(self: *Self, allocator: std.mem.Allocator, input: associate_mac_sec_key.AssociateMacSecKeyInput, options: associate_mac_sec_key.Options) !associate_mac_sec_key.AssociateMacSecKeyOutput {
        return associate_mac_sec_key.execute(self, allocator, input, options);
    }

    /// Associates a virtual interface with a specified link aggregation group (LAG)
    /// or
    /// connection. Connectivity to Amazon Web Services is temporarily interrupted
    /// as the virtual interface is
    /// being migrated. If the target connection or LAG has an associated virtual
    /// interface with
    /// a conflicting VLAN number or a conflicting IP address, the operation fails.
    ///
    /// Virtual interfaces associated with a hosted connection cannot be associated
    /// with a
    /// LAG; hosted connections must be migrated along with their virtual interfaces
    /// using AssociateHostedConnection.
    ///
    /// To reassociate a virtual interface to a new connection or LAG, the requester
    /// must own either the virtual interface itself or the connection to which the
    /// virtual
    /// interface is currently associated. Additionally, the requester must own the
    /// connection
    /// or LAG for the association.
    pub fn associateVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: associate_virtual_interface.AssociateVirtualInterfaceInput, options: associate_virtual_interface.Options) !associate_virtual_interface.AssociateVirtualInterfaceOutput {
        return associate_virtual_interface.execute(self, allocator, input, options);
    }

    /// Confirms the creation of the specified hosted connection on an interconnect.
    ///
    /// Upon creation, the hosted connection is initially in the `Ordering` state,
    /// and
    /// remains in this state until the owner confirms creation of the hosted
    /// connection.
    pub fn confirmConnection(self: *Self, allocator: std.mem.Allocator, input: confirm_connection.ConfirmConnectionInput, options: confirm_connection.Options) !confirm_connection.ConfirmConnectionOutput {
        return confirm_connection.execute(self, allocator, input, options);
    }

    /// The confirmation of the terms of agreement when creating the connection/link
    /// aggregation group (LAG).
    pub fn confirmCustomerAgreement(self: *Self, allocator: std.mem.Allocator, input: confirm_customer_agreement.ConfirmCustomerAgreementInput, options: confirm_customer_agreement.Options) !confirm_customer_agreement.ConfirmCustomerAgreementOutput {
        return confirm_customer_agreement.execute(self, allocator, input, options);
    }

    /// Accepts ownership of a private virtual interface created by another Amazon
    /// Web Services account.
    ///
    /// After the virtual interface owner makes this call, the virtual interface is
    /// created and attached to the specified virtual private gateway or Direct
    /// Connect gateway, and is
    /// made available to handle traffic.
    pub fn confirmPrivateVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: confirm_private_virtual_interface.ConfirmPrivateVirtualInterfaceInput, options: confirm_private_virtual_interface.Options) !confirm_private_virtual_interface.ConfirmPrivateVirtualInterfaceOutput {
        return confirm_private_virtual_interface.execute(self, allocator, input, options);
    }

    /// Accepts ownership of a public virtual interface created by another Amazon
    /// Web Services account.
    ///
    /// After the virtual interface owner makes this call, the specified virtual
    /// interface is
    /// created and made available to handle traffic.
    pub fn confirmPublicVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: confirm_public_virtual_interface.ConfirmPublicVirtualInterfaceInput, options: confirm_public_virtual_interface.Options) !confirm_public_virtual_interface.ConfirmPublicVirtualInterfaceOutput {
        return confirm_public_virtual_interface.execute(self, allocator, input, options);
    }

    /// Accepts ownership of a transit virtual interface created by another Amazon
    /// Web Services account.
    ///
    /// After the owner of the transit virtual interface makes this call, the
    /// specified transit virtual interface is created and made available to handle
    /// traffic.
    pub fn confirmTransitVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: confirm_transit_virtual_interface.ConfirmTransitVirtualInterfaceInput, options: confirm_transit_virtual_interface.Options) !confirm_transit_virtual_interface.ConfirmTransitVirtualInterfaceOutput {
        return confirm_transit_virtual_interface.execute(self, allocator, input, options);
    }

    /// Creates a BGP peer on the specified virtual interface.
    ///
    /// You must create a BGP peer for the corresponding address family (IPv4/IPv6)
    /// in order to
    /// access Amazon Web Services resources that also use that address family.
    ///
    /// If logical redundancy is not supported by the connection, interconnect, or
    /// LAG, the BGP peer cannot
    /// be in the same address family as an existing BGP peer on the virtual
    /// interface.
    ///
    /// When creating a IPv6 BGP peer, omit the Amazon address and customer address.
    /// IPv6 addresses are automatically assigned from
    /// the Amazon pool of IPv6 addresses; you cannot specify custom IPv6 addresses.
    ///
    /// If you let Amazon Web Services auto-assign IPv4 addresses, a /30 CIDR will
    /// be allocated
    /// from 169.254.0.0/16. Amazon Web Services does not recommend this option if
    /// you intend to use
    /// the customer router peer IP address as the source and destination for
    /// traffic. Instead you
    /// should use RFC 1918 or other addressing, and specify the address yourself.
    /// For more
    /// information about RFC 1918 see [
    /// Address Allocation for Private
    /// Internets](https://datatracker.ietf.org/doc/html/rfc1918).
    ///
    /// For a public virtual interface, the Autonomous System Number (ASN) must be
    /// private or already on the allow list for the virtual interface.
    pub fn createBgpPeer(self: *Self, allocator: std.mem.Allocator, input: create_bgp_peer.CreateBGPPeerInput, options: create_bgp_peer.Options) !create_bgp_peer.CreateBGPPeerOutput {
        return create_bgp_peer.execute(self, allocator, input, options);
    }

    /// Creates a connection between a customer network and a specific Direct
    /// Connect location.
    ///
    /// A connection links your internal network to an Direct Connect location over
    /// a standard Ethernet fiber-optic
    /// cable. One end of the cable is connected to your router, the other to an
    /// Direct Connect router.
    ///
    /// To find the locations for your Region, use DescribeLocations.
    ///
    /// You can automatically add the new connection to a link aggregation group
    /// (LAG) by
    /// specifying a LAG ID in the request. This ensures that the new connection is
    /// allocated on the
    /// same Direct Connect endpoint that hosts the specified LAG. If there are no
    /// available ports on the endpoint,
    /// the request fails and no connection is created.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: create_connection.Options) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Creates a Direct Connect gateway, which is an intermediate object that
    /// enables you to connect a set
    /// of virtual interfaces and virtual private gateways. A Direct Connect gateway
    /// is global and visible in any
    /// Amazon Web Services Region after it is created. The virtual interfaces and
    /// virtual private gateways that
    /// are connected through a Direct Connect gateway can be in different Amazon
    /// Web Services Regions. This enables you to
    /// connect to a VPC in any Region, regardless of the Region in which the
    /// virtual interfaces
    /// are located, and pass traffic between them.
    pub fn createDirectConnectGateway(self: *Self, allocator: std.mem.Allocator, input: create_direct_connect_gateway.CreateDirectConnectGatewayInput, options: create_direct_connect_gateway.Options) !create_direct_connect_gateway.CreateDirectConnectGatewayOutput {
        return create_direct_connect_gateway.execute(self, allocator, input, options);
    }

    /// Creates an association between a Direct Connect gateway and a virtual
    /// private gateway. The virtual
    /// private gateway must be attached to a VPC and must not be associated with
    /// another Direct Connect gateway.
    pub fn createDirectConnectGatewayAssociation(self: *Self, allocator: std.mem.Allocator, input: create_direct_connect_gateway_association.CreateDirectConnectGatewayAssociationInput, options: create_direct_connect_gateway_association.Options) !create_direct_connect_gateway_association.CreateDirectConnectGatewayAssociationOutput {
        return create_direct_connect_gateway_association.execute(self, allocator, input, options);
    }

    /// Creates a proposal to associate the specified virtual private gateway or
    /// transit gateway with the specified Direct Connect gateway.
    ///
    /// You can associate a Direct Connect gateway and virtual private gateway or
    /// transit gateway that is owned by any Amazon Web Services account.
    pub fn createDirectConnectGatewayAssociationProposal(self: *Self, allocator: std.mem.Allocator, input: create_direct_connect_gateway_association_proposal.CreateDirectConnectGatewayAssociationProposalInput, options: create_direct_connect_gateway_association_proposal.Options) !create_direct_connect_gateway_association_proposal.CreateDirectConnectGatewayAssociationProposalOutput {
        return create_direct_connect_gateway_association_proposal.execute(self, allocator, input, options);
    }

    /// Creates an interconnect between an Direct Connect Partner's network and a
    /// specific Direct Connect location.
    ///
    /// An interconnect is a connection that is capable of hosting other
    /// connections. The
    /// Direct Connect Partner can use an interconnect to provide Direct Connect
    /// hosted
    /// connections to customers through their own network services. Like a standard
    /// connection, an
    /// interconnect links the partner's network to an Direct Connect location over
    /// a standard Ethernet
    /// fiber-optic cable. One end is connected to the partner's router, the other
    /// to an Direct Connect
    /// router.
    ///
    /// You can automatically add the new interconnect to a link aggregation group
    /// (LAG) by
    /// specifying a LAG ID in the request. This ensures that the new interconnect
    /// is allocated on
    /// the same Direct Connect endpoint that hosts the specified LAG. If there are
    /// no available ports on the
    /// endpoint, the request fails and no interconnect is created.
    ///
    /// For each end customer, the Direct Connect Partner provisions a connection on
    /// their interconnect by calling AllocateHostedConnection.
    /// The end customer can then connect to Amazon Web Services resources by
    /// creating a virtual interface on their connection, using the VLAN assigned to
    /// them by the Direct Connect Partner.
    ///
    /// Intended for use by Direct Connect Partners only.
    pub fn createInterconnect(self: *Self, allocator: std.mem.Allocator, input: create_interconnect.CreateInterconnectInput, options: create_interconnect.Options) !create_interconnect.CreateInterconnectOutput {
        return create_interconnect.execute(self, allocator, input, options);
    }

    /// Creates a link aggregation group (LAG) with the specified number of bundled
    /// physical dedicated connections between the customer network and a specific
    /// Direct Connect location.
    /// A LAG is a logical interface that uses the Link Aggregation Control Protocol
    /// (LACP) to aggregate multiple interfaces, enabling you to treat them as a
    /// single
    /// interface.
    ///
    /// All connections in a LAG must use the same bandwidth (either 1Gbps, 10Gbps,
    /// 100Gbps,
    /// or 400Gbps) and must terminate at the same Direct Connect endpoint.
    ///
    /// You can have up to 10 dedicated connections per location. Regardless of this
    /// limit, if you
    /// request more connections for the LAG than Direct Connect can allocate on a
    /// single endpoint, no LAG is
    /// created..
    ///
    /// You can specify an existing physical dedicated connection or interconnect to
    /// include in
    /// the LAG (which counts towards the total number of connections). Doing so
    /// interrupts the
    /// current physical dedicated connection, and re-establishes them as a member
    /// of the LAG. The LAG
    /// will be created on the same Direct Connect endpoint to which the dedicated
    /// connection terminates. Any
    /// virtual interfaces associated with the dedicated connection are
    /// automatically disassociated
    /// and re-associated with the LAG. The connection ID does not change.
    ///
    /// If the Amazon Web Services account used to create a LAG is a registered
    /// Direct Connect Partner, the LAG is
    /// automatically enabled to host sub-connections. For a LAG owned by a partner,
    /// any associated virtual
    /// interfaces cannot be directly configured.
    pub fn createLag(self: *Self, allocator: std.mem.Allocator, input: create_lag.CreateLagInput, options: create_lag.Options) !create_lag.CreateLagOutput {
        return create_lag.execute(self, allocator, input, options);
    }

    /// Creates a private virtual interface. A virtual interface is the VLAN that
    /// transports Direct Connect traffic.
    /// A private virtual interface can be connected to either a Direct Connect
    /// gateway or a Virtual Private Gateway (VGW).
    /// Connecting the private virtual interface to a Direct Connect gateway enables
    /// the possibility for connecting to multiple
    /// VPCs, including VPCs in different Amazon Web Services Regions. Connecting
    /// the private virtual interface
    /// to a VGW only provides access to a single VPC within the same Region.
    ///
    /// Setting the MTU of a virtual interface to 8500 (jumbo frames) can cause an
    /// update to
    /// the underlying physical connection if it wasn't updated to support jumbo
    /// frames. Updating
    /// the connection disrupts network connectivity for all virtual interfaces
    /// associated with
    /// the connection for up to 30 seconds. To check whether your connection
    /// supports jumbo
    /// frames, call DescribeConnections. To check whether your virtual
    /// interface supports jumbo frames, call DescribeVirtualInterfaces.
    pub fn createPrivateVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: create_private_virtual_interface.CreatePrivateVirtualInterfaceInput, options: create_private_virtual_interface.Options) !create_private_virtual_interface.CreatePrivateVirtualInterfaceOutput {
        return create_private_virtual_interface.execute(self, allocator, input, options);
    }

    /// Creates a public virtual interface. A virtual interface is the VLAN that
    /// transports Direct Connect traffic.
    /// A public virtual interface supports sending traffic to public services of
    /// Amazon Web Services such as Amazon S3.
    ///
    /// When creating an IPv6 public virtual interface (`addressFamily` is `ipv6`),
    /// leave the `customer`
    /// and `amazon` address fields blank to use auto-assigned IPv6 space. Custom
    /// IPv6 addresses are not supported.
    pub fn createPublicVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: create_public_virtual_interface.CreatePublicVirtualInterfaceInput, options: create_public_virtual_interface.Options) !create_public_virtual_interface.CreatePublicVirtualInterfaceOutput {
        return create_public_virtual_interface.execute(self, allocator, input, options);
    }

    /// Creates a transit virtual interface. A transit virtual interface should be
    /// used to access one or more transit gateways associated with Direct Connect
    /// gateways. A transit virtual interface enables the connection of multiple
    /// VPCs attached to a transit gateway to a Direct Connect gateway.
    ///
    /// If you associate your transit gateway with one or more Direct Connect
    /// gateways, the Autonomous System Number (ASN) used by the transit gateway and
    /// the Direct Connect gateway must be different. For example, if you use the
    /// default ASN 64512 for both your the transit gateway and Direct Connect
    /// gateway, the association request fails.
    ///
    /// A jumbo MTU value must be either 1500 or 8500. No other values will be
    /// accepted. Setting
    /// the MTU of a virtual interface to 8500 (jumbo frames) can cause an update to
    /// the underlying
    /// physical connection if it wasn't updated to support jumbo frames. Updating
    /// the connection
    /// disrupts network connectivity for all virtual interfaces associated with the
    /// connection for up
    /// to 30 seconds. To check whether your connection supports jumbo frames, call
    /// DescribeConnections. To check whether your virtual interface supports jumbo
    /// frames, call DescribeVirtualInterfaces.
    pub fn createTransitVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: create_transit_virtual_interface.CreateTransitVirtualInterfaceInput, options: create_transit_virtual_interface.Options) !create_transit_virtual_interface.CreateTransitVirtualInterfaceOutput {
        return create_transit_virtual_interface.execute(self, allocator, input, options);
    }

    /// Deletes the specified BGP peer on the specified virtual interface with the
    /// specified customer address and ASN.
    ///
    /// You cannot delete the last BGP peer from a virtual interface.
    pub fn deleteBgpPeer(self: *Self, allocator: std.mem.Allocator, input: delete_bgp_peer.DeleteBGPPeerInput, options: delete_bgp_peer.Options) !delete_bgp_peer.DeleteBGPPeerOutput {
        return delete_bgp_peer.execute(self, allocator, input, options);
    }

    /// Deletes the specified connection.
    ///
    /// Deleting a connection only stops the Direct Connect port hour and data
    /// transfer charges.
    /// If you are partnering with any third parties to connect with the Direct
    /// Connect location,
    /// you must cancel your service with them separately.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes the specified Direct Connect gateway. You must first delete all
    /// virtual interfaces that are
    /// attached to the Direct Connect gateway and disassociate all virtual private
    /// gateways associated
    /// with the Direct Connect gateway.
    pub fn deleteDirectConnectGateway(self: *Self, allocator: std.mem.Allocator, input: delete_direct_connect_gateway.DeleteDirectConnectGatewayInput, options: delete_direct_connect_gateway.Options) !delete_direct_connect_gateway.DeleteDirectConnectGatewayOutput {
        return delete_direct_connect_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the association between the specified Direct Connect gateway and
    /// virtual private gateway.
    ///
    /// We recommend that you specify the `associationID` to delete the association.
    /// Alternatively, if you own virtual gateway and a Direct Connect gateway
    /// association, you can specify the `virtualGatewayId` and
    /// `directConnectGatewayId` to delete an association.
    pub fn deleteDirectConnectGatewayAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_direct_connect_gateway_association.DeleteDirectConnectGatewayAssociationInput, options: delete_direct_connect_gateway_association.Options) !delete_direct_connect_gateway_association.DeleteDirectConnectGatewayAssociationOutput {
        return delete_direct_connect_gateway_association.execute(self, allocator, input, options);
    }

    /// Deletes the association proposal request between the specified Direct
    /// Connect gateway and virtual private gateway or transit gateway.
    pub fn deleteDirectConnectGatewayAssociationProposal(self: *Self, allocator: std.mem.Allocator, input: delete_direct_connect_gateway_association_proposal.DeleteDirectConnectGatewayAssociationProposalInput, options: delete_direct_connect_gateway_association_proposal.Options) !delete_direct_connect_gateway_association_proposal.DeleteDirectConnectGatewayAssociationProposalOutput {
        return delete_direct_connect_gateway_association_proposal.execute(self, allocator, input, options);
    }

    /// Deletes the specified interconnect.
    ///
    /// Intended for use
    /// by Direct Connect Partners only.
    pub fn deleteInterconnect(self: *Self, allocator: std.mem.Allocator, input: delete_interconnect.DeleteInterconnectInput, options: delete_interconnect.Options) !delete_interconnect.DeleteInterconnectOutput {
        return delete_interconnect.execute(self, allocator, input, options);
    }

    /// Deletes the specified link aggregation group (LAG). You cannot delete a LAG
    /// if it has active
    /// virtual interfaces or hosted connections.
    pub fn deleteLag(self: *Self, allocator: std.mem.Allocator, input: delete_lag.DeleteLagInput, options: delete_lag.Options) !delete_lag.DeleteLagOutput {
        return delete_lag.execute(self, allocator, input, options);
    }

    /// Deletes a virtual interface.
    pub fn deleteVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_interface.DeleteVirtualInterfaceInput, options: delete_virtual_interface.Options) !delete_virtual_interface.DeleteVirtualInterfaceOutput {
        return delete_virtual_interface.execute(self, allocator, input, options);
    }

    /// Deprecated. Use DescribeLoa instead.
    ///
    /// Gets the LOA-CFA for a connection.
    ///
    /// The Letter of Authorization - Connecting Facility Assignment (LOA-CFA) is a
    /// document that your APN partner or
    /// service provider uses when establishing your cross connect to Amazon Web
    /// Services at the colocation facility. For more information,
    /// see [Requesting Cross Connects
    /// at Direct Connect
    /// Locations](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Colocation.html) in the *Direct Connect User Guide*.
    pub fn describeConnectionLoa(self: *Self, allocator: std.mem.Allocator, input: describe_connection_loa.DescribeConnectionLoaInput, options: describe_connection_loa.Options) !describe_connection_loa.DescribeConnectionLoaOutput {
        return describe_connection_loa.execute(self, allocator, input, options);
    }

    /// Displays the specified connection or all connections in this Region.
    pub fn describeConnections(self: *Self, allocator: std.mem.Allocator, input: describe_connections.DescribeConnectionsInput, options: describe_connections.Options) !describe_connections.DescribeConnectionsOutput {
        return describe_connections.execute(self, allocator, input, options);
    }

    /// Deprecated. Use DescribeHostedConnections instead.
    ///
    /// Lists the connections that have been provisioned on the specified
    /// interconnect.
    ///
    /// Intended for use by Direct Connect Partners only.
    pub fn describeConnectionsOnInterconnect(self: *Self, allocator: std.mem.Allocator, input: describe_connections_on_interconnect.DescribeConnectionsOnInterconnectInput, options: describe_connections_on_interconnect.Options) !describe_connections_on_interconnect.DescribeConnectionsOnInterconnectOutput {
        return describe_connections_on_interconnect.execute(self, allocator, input, options);
    }

    /// Get and view a list of customer agreements, along with their signed status
    /// and whether the customer is an NNIPartner, NNIPartnerV2, or a nonPartner.
    pub fn describeCustomerMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_customer_metadata.DescribeCustomerMetadataInput, options: describe_customer_metadata.Options) !describe_customer_metadata.DescribeCustomerMetadataOutput {
        return describe_customer_metadata.execute(self, allocator, input, options);
    }

    /// Describes one or more association proposals for connection between a virtual
    /// private gateway or transit gateway and a Direct Connect gateway.
    pub fn describeDirectConnectGatewayAssociationProposals(self: *Self, allocator: std.mem.Allocator, input: describe_direct_connect_gateway_association_proposals.DescribeDirectConnectGatewayAssociationProposalsInput, options: describe_direct_connect_gateway_association_proposals.Options) !describe_direct_connect_gateway_association_proposals.DescribeDirectConnectGatewayAssociationProposalsOutput {
        return describe_direct_connect_gateway_association_proposals.execute(self, allocator, input, options);
    }

    /// Lists the associations between your Direct Connect gateways and virtual
    /// private gateways and transit gateways. You must specify one of the
    /// following:
    ///
    /// * A Direct Connect gateway
    ///
    /// The response contains all virtual private gateways and transit gateways
    /// associated with the Direct Connect gateway.
    ///
    /// * A virtual private gateway
    ///
    /// The response contains the Direct Connect gateway.
    ///
    /// * A transit gateway
    ///
    /// The response contains the Direct Connect gateway.
    ///
    /// * A Direct Connect gateway and a virtual private gateway
    ///
    /// The response contains the association between the Direct Connect gateway and
    /// virtual private gateway.
    ///
    /// * A Direct Connect gateway and a transit gateway
    ///
    /// The response contains the association between the Direct Connect gateway and
    /// transit gateway.
    ///
    /// * A Direct Connect gateway and a virtual private gateway
    ///
    /// The response contains the association between the Direct Connect gateway and
    /// virtual private gateway.
    ///
    /// * A Direct Connect gateway association to a Cloud WAN core network
    ///
    /// The response contains the Cloud WAN core network ID that the Direct Connect
    /// gateway is associated to.
    pub fn describeDirectConnectGatewayAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_direct_connect_gateway_associations.DescribeDirectConnectGatewayAssociationsInput, options: describe_direct_connect_gateway_associations.Options) !describe_direct_connect_gateway_associations.DescribeDirectConnectGatewayAssociationsOutput {
        return describe_direct_connect_gateway_associations.execute(self, allocator, input, options);
    }

    /// Lists the attachments between your Direct Connect gateways and virtual
    /// interfaces. You must specify
    /// a Direct Connect gateway, a virtual interface, or both. If you specify a
    /// Direct Connect gateway, the response contains
    /// all virtual interfaces attached to the Direct Connect gateway. If you
    /// specify a virtual interface, the
    /// response contains all Direct Connect gateways attached to the virtual
    /// interface. If you specify both,
    /// the response contains the attachment between the Direct Connect gateway and
    /// the virtual interface.
    pub fn describeDirectConnectGatewayAttachments(self: *Self, allocator: std.mem.Allocator, input: describe_direct_connect_gateway_attachments.DescribeDirectConnectGatewayAttachmentsInput, options: describe_direct_connect_gateway_attachments.Options) !describe_direct_connect_gateway_attachments.DescribeDirectConnectGatewayAttachmentsOutput {
        return describe_direct_connect_gateway_attachments.execute(self, allocator, input, options);
    }

    /// Lists all your Direct Connect gateways or only the specified Direct Connect
    /// gateway. Deleted Direct Connect gateways are not returned.
    pub fn describeDirectConnectGateways(self: *Self, allocator: std.mem.Allocator, input: describe_direct_connect_gateways.DescribeDirectConnectGatewaysInput, options: describe_direct_connect_gateways.Options) !describe_direct_connect_gateways.DescribeDirectConnectGatewaysOutput {
        return describe_direct_connect_gateways.execute(self, allocator, input, options);
    }

    /// Lists the hosted connections that have been provisioned on the specified
    /// interconnect or link aggregation group (LAG).
    ///
    /// Intended for use by Direct Connect Partners only.
    pub fn describeHostedConnections(self: *Self, allocator: std.mem.Allocator, input: describe_hosted_connections.DescribeHostedConnectionsInput, options: describe_hosted_connections.Options) !describe_hosted_connections.DescribeHostedConnectionsOutput {
        return describe_hosted_connections.execute(self, allocator, input, options);
    }

    /// Deprecated. Use DescribeLoa instead.
    ///
    /// Gets the LOA-CFA for the specified interconnect.
    ///
    /// The Letter of Authorization - Connecting Facility Assignment (LOA-CFA) is a
    /// document that is used when establishing your cross connect to Amazon Web
    /// Services at the colocation facility.
    /// For more information, see [Requesting Cross Connects at Direct Connect
    /// Locations](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Colocation.html)
    /// in the *Direct Connect User Guide*.
    pub fn describeInterconnectLoa(self: *Self, allocator: std.mem.Allocator, input: describe_interconnect_loa.DescribeInterconnectLoaInput, options: describe_interconnect_loa.Options) !describe_interconnect_loa.DescribeInterconnectLoaOutput {
        return describe_interconnect_loa.execute(self, allocator, input, options);
    }

    /// Lists the interconnects owned by the Amazon Web Services account or only the
    /// specified interconnect.
    pub fn describeInterconnects(self: *Self, allocator: std.mem.Allocator, input: describe_interconnects.DescribeInterconnectsInput, options: describe_interconnects.Options) !describe_interconnects.DescribeInterconnectsOutput {
        return describe_interconnects.execute(self, allocator, input, options);
    }

    /// Describes all your link aggregation groups (LAG) or the specified LAG.
    pub fn describeLags(self: *Self, allocator: std.mem.Allocator, input: describe_lags.DescribeLagsInput, options: describe_lags.Options) !describe_lags.DescribeLagsOutput {
        return describe_lags.execute(self, allocator, input, options);
    }

    /// Gets the LOA-CFA for a connection, interconnect, or link aggregation group
    /// (LAG).
    ///
    /// The Letter of Authorization - Connecting Facility Assignment (LOA-CFA) is a
    /// document that is used when establishing
    /// your cross connect to Amazon Web Services at the colocation facility. For
    /// more information, see [Requesting Cross Connects at Direct Connect
    /// Locations](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Colocation.html)
    /// in the *Direct Connect User Guide*.
    pub fn describeLoa(self: *Self, allocator: std.mem.Allocator, input: describe_loa.DescribeLoaInput, options: describe_loa.Options) !describe_loa.DescribeLoaOutput {
        return describe_loa.execute(self, allocator, input, options);
    }

    /// Lists the Direct Connect locations in the current Amazon Web Services
    /// Region. These are the locations that can be selected when calling
    /// CreateConnection or CreateInterconnect.
    pub fn describeLocations(self: *Self, allocator: std.mem.Allocator, input: describe_locations.DescribeLocationsInput, options: describe_locations.Options) !describe_locations.DescribeLocationsOutput {
        return describe_locations.execute(self, allocator, input, options);
    }

    /// Details about the router.
    pub fn describeRouterConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_router_configuration.DescribeRouterConfigurationInput, options: describe_router_configuration.Options) !describe_router_configuration.DescribeRouterConfigurationOutput {
        return describe_router_configuration.execute(self, allocator, input, options);
    }

    /// Describes the tags associated with the specified Direct Connect resources.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: describe_tags.Options) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Deprecated. Use `DescribeVpnGateways` instead. See
    /// [DescribeVPNGateways](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpnGateways.html) in the *Amazon Elastic Compute Cloud API Reference*.
    ///
    /// Lists the virtual private gateways owned by the Amazon Web Services account.
    ///
    /// You can create one or more Direct Connect private virtual interfaces linked
    /// to a virtual private gateway.
    pub fn describeVirtualGateways(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_gateways.DescribeVirtualGatewaysInput, options: describe_virtual_gateways.Options) !describe_virtual_gateways.DescribeVirtualGatewaysOutput {
        return describe_virtual_gateways.execute(self, allocator, input, options);
    }

    /// Displays all virtual interfaces for an Amazon Web Services account. Virtual
    /// interfaces deleted fewer
    /// than 15 minutes before you make the request are also returned. If you
    /// specify a
    /// connection ID, only the virtual interfaces associated with the connection
    /// are returned.
    /// If you specify a virtual interface ID, then only a single virtual interface
    /// is returned.
    ///
    /// A virtual interface (VLAN) transmits the traffic between the Direct Connect
    /// location and the customer network.
    ///
    /// * If you're using an `asn`, the response includes ASN value in both the
    ///   `asn` and `asnLong` fields.
    ///
    /// * If you're using `asnLong`, the response returns a value of `0` (zero) for
    ///   the `asn` attribute because it exceeds the highest ASN value of
    ///   2,147,483,647 that it can support
    pub fn describeVirtualInterfaces(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_interfaces.DescribeVirtualInterfacesInput, options: describe_virtual_interfaces.Options) !describe_virtual_interfaces.DescribeVirtualInterfacesOutput {
        return describe_virtual_interfaces.execute(self, allocator, input, options);
    }

    /// Disassociates a connection from a link aggregation group (LAG). The
    /// connection is
    /// interrupted and re-established as a standalone connection (the connection is
    /// not
    /// deleted; to delete the connection, use the DeleteConnection request).
    /// If the LAG has associated virtual interfaces or hosted connections, they
    /// remain
    /// associated with the LAG. A disassociated connection owned by an Direct
    /// Connect Partner is
    /// automatically converted to an interconnect.
    ///
    /// If disassociating the connection would cause the LAG to fall below its
    /// setting for
    /// minimum number of operational connections, the request fails, except when
    /// it's the last
    /// member of the LAG. If all connections are disassociated, the LAG continues
    /// to exist as
    /// an empty LAG with no physical connections.
    pub fn disassociateConnectionFromLag(self: *Self, allocator: std.mem.Allocator, input: disassociate_connection_from_lag.DisassociateConnectionFromLagInput, options: disassociate_connection_from_lag.Options) !disassociate_connection_from_lag.DisassociateConnectionFromLagOutput {
        return disassociate_connection_from_lag.execute(self, allocator, input, options);
    }

    /// Removes the association between a MAC Security (MACsec) security key and a
    /// Direct Connect connection.
    pub fn disassociateMacSecKey(self: *Self, allocator: std.mem.Allocator, input: disassociate_mac_sec_key.DisassociateMacSecKeyInput, options: disassociate_mac_sec_key.Options) !disassociate_mac_sec_key.DisassociateMacSecKeyOutput {
        return disassociate_mac_sec_key.execute(self, allocator, input, options);
    }

    /// Lists the virtual interface failover test history.
    pub fn listVirtualInterfaceTestHistory(self: *Self, allocator: std.mem.Allocator, input: list_virtual_interface_test_history.ListVirtualInterfaceTestHistoryInput, options: list_virtual_interface_test_history.Options) !list_virtual_interface_test_history.ListVirtualInterfaceTestHistoryOutput {
        return list_virtual_interface_test_history.execute(self, allocator, input, options);
    }

    /// Starts the virtual interface failover test that verifies your configuration
    /// meets your resiliency requirements by placing the BGP peering session in the
    /// DOWN state. You can then send traffic to verify that there are no outages.
    ///
    /// You can run the test on public, private, transit, and hosted virtual
    /// interfaces.
    ///
    /// You can use
    /// [ListVirtualInterfaceTestHistory](https://docs.aws.amazon.com/directconnect/latest/APIReference/API_ListVirtualInterfaceTestHistory.html) to view the virtual interface test history.
    ///
    /// If you need to stop the test before the test interval completes, use
    /// [StopBgpFailoverTest](https://docs.aws.amazon.com/directconnect/latest/APIReference/API_StopBgpFailoverTest.html).
    pub fn startBgpFailoverTest(self: *Self, allocator: std.mem.Allocator, input: start_bgp_failover_test.StartBgpFailoverTestInput, options: start_bgp_failover_test.Options) !start_bgp_failover_test.StartBgpFailoverTestOutput {
        return start_bgp_failover_test.execute(self, allocator, input, options);
    }

    /// Stops the virtual interface failover test.
    pub fn stopBgpFailoverTest(self: *Self, allocator: std.mem.Allocator, input: stop_bgp_failover_test.StopBgpFailoverTestInput, options: stop_bgp_failover_test.Options) !stop_bgp_failover_test.StopBgpFailoverTestOutput {
        return stop_bgp_failover_test.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified Direct Connect resource. Each
    /// resource can have a maximum of 50 tags.
    ///
    /// Each tag consists of a key and an optional value. If a tag with the same key
    /// is already associated with the resource, this action updates its value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified Direct Connect resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the Direct Connect connection configuration.
    ///
    /// You can update the following parameters for a connection:
    ///
    /// * The connection name
    ///
    /// * The connection's MAC Security (MACsec) encryption mode.
    pub fn updateConnection(self: *Self, allocator: std.mem.Allocator, input: update_connection.UpdateConnectionInput, options: update_connection.Options) !update_connection.UpdateConnectionOutput {
        return update_connection.execute(self, allocator, input, options);
    }

    /// Updates the name of a current Direct Connect gateway.
    pub fn updateDirectConnectGateway(self: *Self, allocator: std.mem.Allocator, input: update_direct_connect_gateway.UpdateDirectConnectGatewayInput, options: update_direct_connect_gateway.Options) !update_direct_connect_gateway.UpdateDirectConnectGatewayOutput {
        return update_direct_connect_gateway.execute(self, allocator, input, options);
    }

    /// Updates the specified attributes of the Direct Connect gateway association.
    ///
    /// Add or remove prefixes from the association.
    pub fn updateDirectConnectGatewayAssociation(self: *Self, allocator: std.mem.Allocator, input: update_direct_connect_gateway_association.UpdateDirectConnectGatewayAssociationInput, options: update_direct_connect_gateway_association.Options) !update_direct_connect_gateway_association.UpdateDirectConnectGatewayAssociationOutput {
        return update_direct_connect_gateway_association.execute(self, allocator, input, options);
    }

    /// Updates the attributes of the specified link aggregation group (LAG).
    ///
    /// You can update the following LAG attributes:
    ///
    /// * The name of the LAG.
    ///
    /// * The value for the minimum number of connections that must be operational
    /// for the LAG itself to be operational.
    ///
    /// * The LAG's MACsec encryption mode.
    ///
    /// Amazon Web Services assigns this value to each connection which is part of
    /// the LAG.
    ///
    /// * The tags
    ///
    /// If you adjust the threshold value for the minimum number of operational
    /// connections, ensure
    /// that the new value does not cause the LAG to fall below the threshold and
    /// become
    /// non-operational.
    pub fn updateLag(self: *Self, allocator: std.mem.Allocator, input: update_lag.UpdateLagInput, options: update_lag.Options) !update_lag.UpdateLagOutput {
        return update_lag.execute(self, allocator, input, options);
    }

    /// Updates the specified attributes of the specified virtual private interface.
    ///
    /// Setting the MTU of a virtual interface to 8500 (jumbo frames) can cause an
    /// update to
    /// the underlying physical connection if it wasn't updated to support jumbo
    /// frames. Updating
    /// the connection disrupts network connectivity for all virtual interfaces
    /// associated with
    /// the connection for up to 30 seconds. To check whether your connection
    /// supports jumbo
    /// frames, call DescribeConnections. To check whether your virtual
    /// interface supports jumbo frames, call DescribeVirtualInterfaces.
    pub fn updateVirtualInterfaceAttributes(self: *Self, allocator: std.mem.Allocator, input: update_virtual_interface_attributes.UpdateVirtualInterfaceAttributesInput, options: update_virtual_interface_attributes.Options) !update_virtual_interface_attributes.UpdateVirtualInterfaceAttributesOutput {
        return update_virtual_interface_attributes.execute(self, allocator, input, options);
    }
};
