const aws = @import("aws");
const std = @import("std");

const add_custom_routing_endpoints = @import("add_custom_routing_endpoints.zig");
const add_endpoints = @import("add_endpoints.zig");
const advertise_byoip_cidr = @import("advertise_byoip_cidr.zig");
const allow_custom_routing_traffic = @import("allow_custom_routing_traffic.zig");
const create_accelerator = @import("create_accelerator.zig");
const create_cross_account_attachment = @import("create_cross_account_attachment.zig");
const create_custom_routing_accelerator = @import("create_custom_routing_accelerator.zig");
const create_custom_routing_endpoint_group = @import("create_custom_routing_endpoint_group.zig");
const create_custom_routing_listener = @import("create_custom_routing_listener.zig");
const create_endpoint_group = @import("create_endpoint_group.zig");
const create_listener = @import("create_listener.zig");
const delete_accelerator = @import("delete_accelerator.zig");
const delete_cross_account_attachment = @import("delete_cross_account_attachment.zig");
const delete_custom_routing_accelerator = @import("delete_custom_routing_accelerator.zig");
const delete_custom_routing_endpoint_group = @import("delete_custom_routing_endpoint_group.zig");
const delete_custom_routing_listener = @import("delete_custom_routing_listener.zig");
const delete_endpoint_group = @import("delete_endpoint_group.zig");
const delete_listener = @import("delete_listener.zig");
const deny_custom_routing_traffic = @import("deny_custom_routing_traffic.zig");
const deprovision_byoip_cidr = @import("deprovision_byoip_cidr.zig");
const describe_accelerator = @import("describe_accelerator.zig");
const describe_accelerator_attributes = @import("describe_accelerator_attributes.zig");
const describe_cross_account_attachment = @import("describe_cross_account_attachment.zig");
const describe_custom_routing_accelerator = @import("describe_custom_routing_accelerator.zig");
const describe_custom_routing_accelerator_attributes = @import("describe_custom_routing_accelerator_attributes.zig");
const describe_custom_routing_endpoint_group = @import("describe_custom_routing_endpoint_group.zig");
const describe_custom_routing_listener = @import("describe_custom_routing_listener.zig");
const describe_endpoint_group = @import("describe_endpoint_group.zig");
const describe_listener = @import("describe_listener.zig");
const list_accelerators = @import("list_accelerators.zig");
const list_byoip_cidrs = @import("list_byoip_cidrs.zig");
const list_cross_account_attachments = @import("list_cross_account_attachments.zig");
const list_cross_account_resource_accounts = @import("list_cross_account_resource_accounts.zig");
const list_cross_account_resources = @import("list_cross_account_resources.zig");
const list_custom_routing_accelerators = @import("list_custom_routing_accelerators.zig");
const list_custom_routing_endpoint_groups = @import("list_custom_routing_endpoint_groups.zig");
const list_custom_routing_listeners = @import("list_custom_routing_listeners.zig");
const list_custom_routing_port_mappings = @import("list_custom_routing_port_mappings.zig");
const list_custom_routing_port_mappings_by_destination = @import("list_custom_routing_port_mappings_by_destination.zig");
const list_endpoint_groups = @import("list_endpoint_groups.zig");
const list_listeners = @import("list_listeners.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const provision_byoip_cidr = @import("provision_byoip_cidr.zig");
const remove_custom_routing_endpoints = @import("remove_custom_routing_endpoints.zig");
const remove_endpoints = @import("remove_endpoints.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_accelerator = @import("update_accelerator.zig");
const update_accelerator_attributes = @import("update_accelerator_attributes.zig");
const update_cross_account_attachment = @import("update_cross_account_attachment.zig");
const update_custom_routing_accelerator = @import("update_custom_routing_accelerator.zig");
const update_custom_routing_accelerator_attributes = @import("update_custom_routing_accelerator_attributes.zig");
const update_custom_routing_listener = @import("update_custom_routing_listener.zig");
const update_endpoint_group = @import("update_endpoint_group.zig");
const update_listener = @import("update_listener.zig");
const withdraw_byoip_cidr = @import("withdraw_byoip_cidr.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Global Accelerator";

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

    /// Associate a virtual private cloud (VPC) subnet endpoint with your custom
    /// routing accelerator.
    ///
    /// The listener port range must be large enough to support the number of IP
    /// addresses that can be
    /// specified in your subnet. The number of ports required is: subnet size times
    /// the number
    /// of ports per destination EC2 instances. For example, a subnet defined as /24
    /// requires a listener
    /// port range of at least 255 ports.
    ///
    /// Note: You must have enough remaining listener ports available to
    /// map to the subnet ports, or the call will fail with a
    /// LimitExceededException.
    ///
    /// By default, all destinations in a subnet in a custom routing accelerator
    /// cannot receive traffic. To enable all
    /// destinations to receive traffic, or to specify individual port mappings that
    /// can receive
    /// traffic, see the [
    /// AllowCustomRoutingTraffic](https://docs.aws.amazon.com/global-accelerator/latest/api/API_AllowCustomRoutingTraffic.html) operation.
    pub fn addCustomRoutingEndpoints(self: *Self, allocator: std.mem.Allocator, input: add_custom_routing_endpoints.AddCustomRoutingEndpointsInput, options: CallOptions) !add_custom_routing_endpoints.AddCustomRoutingEndpointsOutput {
        return add_custom_routing_endpoints.execute(self, allocator, input, options);
    }

    /// Add endpoints to an endpoint group. The `AddEndpoints` API operation is the
    /// recommended option for adding endpoints. The
    /// alternative options are to add endpoints when you create an endpoint group
    /// (with the
    /// [CreateEndpointGroup](https://docs.aws.amazon.com/global-accelerator/latest/api/API_CreateEndpointGroup.html) API)
    /// or when you update an endpoint group (with the
    /// [UpdateEndpointGroup](https://docs.aws.amazon.com/global-accelerator/latest/api/API_UpdateEndpointGroup.html) API).
    ///
    /// There are two advantages to using `AddEndpoints` to add endpoints in Global
    /// Accelerator:
    ///
    /// * It's faster, because Global Accelerator only has to resolve the new
    ///   endpoints that
    /// you're adding, rather than resolving new and existing endpoints.
    ///
    /// * It's more convenient, because you don't need to specify the current
    /// endpoints that are already in the endpoint group, in addition to the new
    /// endpoints that
    /// you want to add.
    ///
    /// For information about endpoint types and requirements for endpoints that you
    /// can add
    /// to Global Accelerator, see [
    /// Endpoints for standard
    /// accelerators](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoints.html) in the *Global Accelerator Developer Guide*.
    pub fn addEndpoints(self: *Self, allocator: std.mem.Allocator, input: add_endpoints.AddEndpointsInput, options: CallOptions) !add_endpoints.AddEndpointsOutput {
        return add_endpoints.execute(self, allocator, input, options);
    }

    /// Advertises an IPv4 address range that is provisioned for use with your
    /// Amazon Web Services resources
    /// through bring your own IP addresses (BYOIP). It can take a few minutes
    /// before traffic to
    /// the specified addresses starts routing to Amazon Web Services because of
    /// propagation delays.
    ///
    /// To stop advertising the BYOIP address range, use [
    /// WithdrawByoipCidr](https://docs.aws.amazon.com/global-accelerator/latest/api/WithdrawByoipCidr.html).
    ///
    /// For more information, see [Bring your own
    /// IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
    pub fn advertiseByoipCidr(self: *Self, allocator: std.mem.Allocator, input: advertise_byoip_cidr.AdvertiseByoipCidrInput, options: CallOptions) !advertise_byoip_cidr.AdvertiseByoipCidrOutput {
        return advertise_byoip_cidr.execute(self, allocator, input, options);
    }

    /// Specify the Amazon EC2 instance (destination) IP addresses and ports for a
    /// VPC subnet endpoint that can receive traffic
    /// for a custom routing accelerator. You can allow traffic to all destinations
    /// in the subnet endpoint, or allow traffic to a
    /// specified list of destination IP addresses and ports in the subnet. Note
    /// that you cannot specify IP addresses or ports
    /// outside of the range that you configured for the endpoint group.
    ///
    /// After you make changes, you can verify that the updates are complete by
    /// checking the status of your
    /// accelerator: the status changes from IN_PROGRESS to DEPLOYED.
    pub fn allowCustomRoutingTraffic(self: *Self, allocator: std.mem.Allocator, input: allow_custom_routing_traffic.AllowCustomRoutingTrafficInput, options: CallOptions) !allow_custom_routing_traffic.AllowCustomRoutingTrafficOutput {
        return allow_custom_routing_traffic.execute(self, allocator, input, options);
    }

    /// Create an accelerator. An accelerator includes one or more listeners that
    /// process inbound connections and direct traffic
    /// to one or more endpoint groups, each of which includes endpoints, such as
    /// Network Load Balancers.
    ///
    /// Global Accelerator is a global service that supports endpoints in multiple
    /// Amazon Web Services Regions but you must specify the
    /// US West (Oregon) Region to create, update, or otherwise work with
    /// accelerators. That is, for example, specify `--region us-west-2`
    /// on Amazon Web Services CLI commands.
    pub fn createAccelerator(self: *Self, allocator: std.mem.Allocator, input: create_accelerator.CreateAcceleratorInput, options: CallOptions) !create_accelerator.CreateAcceleratorOutput {
        return create_accelerator.execute(self, allocator, input, options);
    }

    /// Create a cross-account attachment in Global Accelerator. You create a
    /// cross-account attachment to
    /// specify the *principals* who have permission to work with *resources*
    /// in accelerators in their own account. You specify, in the same attachment,
    /// the resources that are shared.
    ///
    /// A principal can be an Amazon Web Services account number or the Amazon
    /// Resource Name (ARN) for an
    /// accelerator. For account numbers that are listed as principals, to work with
    /// a resource listed in the attachment,
    /// you must sign in to an account specified as a principal. Then, you can work
    /// with resources that are listed,
    /// with any of your accelerators. If an accelerator ARN is listed in the
    /// cross-account attachment as a principal,
    /// anyone with permission to make updates to the accelerator can work with
    /// resources that are listed in the
    /// attachment.
    ///
    /// Specify each principal and resource separately. To specify two CIDR address
    /// pools, list
    /// them individually under `Resources`, and so on. For a command line
    /// operation, for example,
    /// you might use a statement like the following:
    ///
    /// ` "Resources": [{"Cidr": "169.254.60.0/24"},{"Cidr": "169.254.59.0/24"}]`
    ///
    /// For more information, see [
    /// Working with cross-account attachments and resources in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/cross-account-resources.html) in the *
    /// Global Accelerator Developer Guide*.
    pub fn createCrossAccountAttachment(self: *Self, allocator: std.mem.Allocator, input: create_cross_account_attachment.CreateCrossAccountAttachmentInput, options: CallOptions) !create_cross_account_attachment.CreateCrossAccountAttachmentOutput {
        return create_cross_account_attachment.execute(self, allocator, input, options);
    }

    /// Create a custom routing accelerator. A custom routing accelerator directs
    /// traffic to one of possibly thousands
    /// of Amazon EC2 instance destinations running in a single or multiple virtual
    /// private clouds (VPC) subnet endpoints.
    ///
    /// Be aware that, by default, all destination EC2 instances in a VPC subnet
    /// endpoint cannot receive
    /// traffic. To enable all destinations to receive traffic, or to specify
    /// individual port
    /// mappings that can receive traffic, see the [
    /// AllowCustomRoutingTraffic](https://docs.aws.amazon.com/global-accelerator/latest/api/API_AllowCustomRoutingTraffic.html) operation.
    ///
    /// Global Accelerator is a global service that supports endpoints in multiple
    /// Amazon Web Services Regions but you must specify the
    /// US West (Oregon) Region to create, update, or otherwise work with
    /// accelerators. That is, for example, specify `--region us-west-2`
    /// on Amazon Web Services CLI commands.
    pub fn createCustomRoutingAccelerator(self: *Self, allocator: std.mem.Allocator, input: create_custom_routing_accelerator.CreateCustomRoutingAcceleratorInput, options: CallOptions) !create_custom_routing_accelerator.CreateCustomRoutingAcceleratorOutput {
        return create_custom_routing_accelerator.execute(self, allocator, input, options);
    }

    /// Create an endpoint group for the specified listener for a custom routing
    /// accelerator.
    /// An endpoint group is a collection of endpoints in one Amazon Web Services
    /// Region.
    pub fn createCustomRoutingEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: create_custom_routing_endpoint_group.CreateCustomRoutingEndpointGroupInput, options: CallOptions) !create_custom_routing_endpoint_group.CreateCustomRoutingEndpointGroupOutput {
        return create_custom_routing_endpoint_group.execute(self, allocator, input, options);
    }

    /// Create a listener to process inbound connections from clients to a custom
    /// routing accelerator.
    /// Connections arrive to assigned static IP addresses on the port range that
    /// you specify.
    pub fn createCustomRoutingListener(self: *Self, allocator: std.mem.Allocator, input: create_custom_routing_listener.CreateCustomRoutingListenerInput, options: CallOptions) !create_custom_routing_listener.CreateCustomRoutingListenerOutput {
        return create_custom_routing_listener.execute(self, allocator, input, options);
    }

    /// Create an endpoint group for the specified listener. An endpoint group is a
    /// collection of endpoints in one Amazon Web Services
    /// Region. A resource must be valid and active when you add it as an endpoint.
    ///
    /// For more information about endpoint types and requirements for endpoints
    /// that you can add
    /// to Global Accelerator, see [
    /// Endpoints for standard
    /// accelerators](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoints.html) in the *Global Accelerator Developer Guide*.
    pub fn createEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: create_endpoint_group.CreateEndpointGroupInput, options: CallOptions) !create_endpoint_group.CreateEndpointGroupOutput {
        return create_endpoint_group.execute(self, allocator, input, options);
    }

    /// Create a listener to process inbound connections from clients to an
    /// accelerator. Connections arrive to assigned static
    /// IP addresses on a port, port range, or list of port ranges that you specify.
    pub fn createListener(self: *Self, allocator: std.mem.Allocator, input: create_listener.CreateListenerInput, options: CallOptions) !create_listener.CreateListenerOutput {
        return create_listener.execute(self, allocator, input, options);
    }

    /// Delete an accelerator. Before you can delete an accelerator, you must
    /// disable it and remove all dependent resources
    /// (listeners and endpoint groups). To disable the accelerator, update the
    /// accelerator to set `Enabled` to false.
    ///
    /// When you create an accelerator, by default, Global Accelerator provides you
    /// with a set of two static IP addresses.
    /// Alternatively, you can bring your own IP address ranges to Global
    /// Accelerator and assign IP addresses from those ranges.
    ///
    /// The IP addresses are assigned to your accelerator for as long as it exists,
    /// even if you disable the accelerator and
    /// it no longer accepts or routes traffic. However, when you *delete* an
    /// accelerator, you lose the
    /// static IP addresses that are assigned to the accelerator, so you can no
    /// longer route traffic by using them.
    /// As a best practice, ensure that you have permissions in place to avoid
    /// inadvertently deleting accelerators. You
    /// can use IAM policies with Global Accelerator to limit the users who have
    /// permissions to delete an accelerator. For more information,
    /// see [Identity and access
    /// management](https://docs.aws.amazon.com/global-accelerator/latest/dg/auth-and-access-control.html) in
    /// the *Global Accelerator Developer Guide*.
    pub fn deleteAccelerator(self: *Self, allocator: std.mem.Allocator, input: delete_accelerator.DeleteAcceleratorInput, options: CallOptions) !delete_accelerator.DeleteAcceleratorOutput {
        return delete_accelerator.execute(self, allocator, input, options);
    }

    /// Delete a cross-account attachment. When you delete an attachment, Global
    /// Accelerator revokes the permission
    /// to use the resources in the attachment from all principals in the list of
    /// principals. Global Accelerator
    /// revokes the permission for specific resources.
    ///
    /// For more information, see [
    /// Working with cross-account attachments and resources in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/cross-account-resources.html) in the *
    /// Global Accelerator Developer Guide*.
    pub fn deleteCrossAccountAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_cross_account_attachment.DeleteCrossAccountAttachmentInput, options: CallOptions) !delete_cross_account_attachment.DeleteCrossAccountAttachmentOutput {
        return delete_cross_account_attachment.execute(self, allocator, input, options);
    }

    /// Delete a custom routing accelerator. Before you can delete an accelerator,
    /// you must disable it and remove all dependent resources
    /// (listeners and endpoint groups). To disable the accelerator, update the
    /// accelerator to set `Enabled` to false.
    ///
    /// When you create a custom routing accelerator, by default, Global Accelerator
    /// provides you with a set of two static IP addresses.
    ///
    /// The IP
    /// addresses are assigned to your accelerator for as long as it exists, even if
    /// you disable the accelerator and
    /// it no longer accepts or routes traffic. However, when you *delete* an
    /// accelerator, you lose the
    /// static IP addresses that are assigned to the accelerator, so you can no
    /// longer route traffic by using them.
    /// As a best practice, ensure that you have permissions in place to avoid
    /// inadvertently deleting accelerators. You
    /// can use IAM policies with Global Accelerator to limit the users who have
    /// permissions to delete an accelerator. For more information,
    /// see [Identity and access
    /// management](https://docs.aws.amazon.com/global-accelerator/latest/dg/auth-and-access-control.html) in
    /// the *Global Accelerator Developer Guide*.
    pub fn deleteCustomRoutingAccelerator(self: *Self, allocator: std.mem.Allocator, input: delete_custom_routing_accelerator.DeleteCustomRoutingAcceleratorInput, options: CallOptions) !delete_custom_routing_accelerator.DeleteCustomRoutingAcceleratorOutput {
        return delete_custom_routing_accelerator.execute(self, allocator, input, options);
    }

    /// Delete an endpoint group from a listener for a custom routing accelerator.
    pub fn deleteCustomRoutingEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: delete_custom_routing_endpoint_group.DeleteCustomRoutingEndpointGroupInput, options: CallOptions) !delete_custom_routing_endpoint_group.DeleteCustomRoutingEndpointGroupOutput {
        return delete_custom_routing_endpoint_group.execute(self, allocator, input, options);
    }

    /// Delete a listener for a custom routing accelerator.
    pub fn deleteCustomRoutingListener(self: *Self, allocator: std.mem.Allocator, input: delete_custom_routing_listener.DeleteCustomRoutingListenerInput, options: CallOptions) !delete_custom_routing_listener.DeleteCustomRoutingListenerOutput {
        return delete_custom_routing_listener.execute(self, allocator, input, options);
    }

    /// Delete an endpoint group from a listener.
    pub fn deleteEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint_group.DeleteEndpointGroupInput, options: CallOptions) !delete_endpoint_group.DeleteEndpointGroupOutput {
        return delete_endpoint_group.execute(self, allocator, input, options);
    }

    /// Delete a listener from an accelerator.
    pub fn deleteListener(self: *Self, allocator: std.mem.Allocator, input: delete_listener.DeleteListenerInput, options: CallOptions) !delete_listener.DeleteListenerOutput {
        return delete_listener.execute(self, allocator, input, options);
    }

    /// Specify the Amazon EC2 instance (destination) IP addresses and ports for a
    /// VPC subnet endpoint that cannot receive traffic
    /// for a custom routing accelerator. You can deny traffic to all destinations
    /// in the VPC endpoint, or deny traffic to a
    /// specified list of destination IP addresses and ports. Note that you cannot
    /// specify IP addresses
    /// or ports outside of the range that you configured for the endpoint group.
    ///
    /// After you make changes, you can verify that the updates are complete by
    /// checking the status of your
    /// accelerator: the status changes from IN_PROGRESS to DEPLOYED.
    pub fn denyCustomRoutingTraffic(self: *Self, allocator: std.mem.Allocator, input: deny_custom_routing_traffic.DenyCustomRoutingTrafficInput, options: CallOptions) !deny_custom_routing_traffic.DenyCustomRoutingTrafficOutput {
        return deny_custom_routing_traffic.execute(self, allocator, input, options);
    }

    /// Releases the specified address range that you provisioned to use with your
    /// Amazon Web Services resources
    /// through bring your own IP addresses (BYOIP) and deletes the corresponding
    /// address pool.
    ///
    /// Before you can release an address range, you must stop advertising it by
    /// using
    /// [WithdrawByoipCidr](https://docs.aws.amazon.com/global-accelerator/latest/api/WithdrawByoipCidr.html) and you must not have
    /// any accelerators that are using static IP addresses allocated from its
    /// address range.
    ///
    /// For more information, see [Bring
    /// your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
    pub fn deprovisionByoipCidr(self: *Self, allocator: std.mem.Allocator, input: deprovision_byoip_cidr.DeprovisionByoipCidrInput, options: CallOptions) !deprovision_byoip_cidr.DeprovisionByoipCidrOutput {
        return deprovision_byoip_cidr.execute(self, allocator, input, options);
    }

    /// Describe an accelerator.
    pub fn describeAccelerator(self: *Self, allocator: std.mem.Allocator, input: describe_accelerator.DescribeAcceleratorInput, options: CallOptions) !describe_accelerator.DescribeAcceleratorOutput {
        return describe_accelerator.execute(self, allocator, input, options);
    }

    /// Describe the attributes of an accelerator.
    pub fn describeAcceleratorAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_accelerator_attributes.DescribeAcceleratorAttributesInput, options: CallOptions) !describe_accelerator_attributes.DescribeAcceleratorAttributesOutput {
        return describe_accelerator_attributes.execute(self, allocator, input, options);
    }

    /// Gets configuration information about a cross-account attachment.
    pub fn describeCrossAccountAttachment(self: *Self, allocator: std.mem.Allocator, input: describe_cross_account_attachment.DescribeCrossAccountAttachmentInput, options: CallOptions) !describe_cross_account_attachment.DescribeCrossAccountAttachmentOutput {
        return describe_cross_account_attachment.execute(self, allocator, input, options);
    }

    /// Describe a custom routing accelerator.
    pub fn describeCustomRoutingAccelerator(self: *Self, allocator: std.mem.Allocator, input: describe_custom_routing_accelerator.DescribeCustomRoutingAcceleratorInput, options: CallOptions) !describe_custom_routing_accelerator.DescribeCustomRoutingAcceleratorOutput {
        return describe_custom_routing_accelerator.execute(self, allocator, input, options);
    }

    /// Describe the attributes of a custom routing accelerator.
    pub fn describeCustomRoutingAcceleratorAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_custom_routing_accelerator_attributes.DescribeCustomRoutingAcceleratorAttributesInput, options: CallOptions) !describe_custom_routing_accelerator_attributes.DescribeCustomRoutingAcceleratorAttributesOutput {
        return describe_custom_routing_accelerator_attributes.execute(self, allocator, input, options);
    }

    /// Describe an endpoint group for a custom routing accelerator.
    pub fn describeCustomRoutingEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: describe_custom_routing_endpoint_group.DescribeCustomRoutingEndpointGroupInput, options: CallOptions) !describe_custom_routing_endpoint_group.DescribeCustomRoutingEndpointGroupOutput {
        return describe_custom_routing_endpoint_group.execute(self, allocator, input, options);
    }

    /// The description of a listener for a custom routing accelerator.
    pub fn describeCustomRoutingListener(self: *Self, allocator: std.mem.Allocator, input: describe_custom_routing_listener.DescribeCustomRoutingListenerInput, options: CallOptions) !describe_custom_routing_listener.DescribeCustomRoutingListenerOutput {
        return describe_custom_routing_listener.execute(self, allocator, input, options);
    }

    /// Describe an endpoint group.
    pub fn describeEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint_group.DescribeEndpointGroupInput, options: CallOptions) !describe_endpoint_group.DescribeEndpointGroupOutput {
        return describe_endpoint_group.execute(self, allocator, input, options);
    }

    /// Describe a listener.
    pub fn describeListener(self: *Self, allocator: std.mem.Allocator, input: describe_listener.DescribeListenerInput, options: CallOptions) !describe_listener.DescribeListenerOutput {
        return describe_listener.execute(self, allocator, input, options);
    }

    /// List the accelerators for an Amazon Web Services account.
    pub fn listAccelerators(self: *Self, allocator: std.mem.Allocator, input: list_accelerators.ListAcceleratorsInput, options: CallOptions) !list_accelerators.ListAcceleratorsOutput {
        return list_accelerators.execute(self, allocator, input, options);
    }

    /// Lists the IP address ranges that were specified in calls to
    /// [ProvisionByoipCidr](https://docs.aws.amazon.com/global-accelerator/latest/api/ProvisionByoipCidr.html), including
    /// the current state and a history of state changes.
    pub fn listByoipCidrs(self: *Self, allocator: std.mem.Allocator, input: list_byoip_cidrs.ListByoipCidrsInput, options: CallOptions) !list_byoip_cidrs.ListByoipCidrsOutput {
        return list_byoip_cidrs.execute(self, allocator, input, options);
    }

    /// List the cross-account attachments that have been created in Global
    /// Accelerator.
    pub fn listCrossAccountAttachments(self: *Self, allocator: std.mem.Allocator, input: list_cross_account_attachments.ListCrossAccountAttachmentsInput, options: CallOptions) !list_cross_account_attachments.ListCrossAccountAttachmentsOutput {
        return list_cross_account_attachments.execute(self, allocator, input, options);
    }

    /// List the accounts that have cross-account resources.
    ///
    /// For more information, see [
    /// Working with cross-account attachments and resources in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/cross-account-resources.html) in the *
    /// Global Accelerator Developer Guide*.
    pub fn listCrossAccountResourceAccounts(self: *Self, allocator: std.mem.Allocator, input: list_cross_account_resource_accounts.ListCrossAccountResourceAccountsInput, options: CallOptions) !list_cross_account_resource_accounts.ListCrossAccountResourceAccountsOutput {
        return list_cross_account_resource_accounts.execute(self, allocator, input, options);
    }

    /// List the cross-account resources available to work with.
    pub fn listCrossAccountResources(self: *Self, allocator: std.mem.Allocator, input: list_cross_account_resources.ListCrossAccountResourcesInput, options: CallOptions) !list_cross_account_resources.ListCrossAccountResourcesOutput {
        return list_cross_account_resources.execute(self, allocator, input, options);
    }

    /// List the custom routing accelerators for an Amazon Web Services account.
    pub fn listCustomRoutingAccelerators(self: *Self, allocator: std.mem.Allocator, input: list_custom_routing_accelerators.ListCustomRoutingAcceleratorsInput, options: CallOptions) !list_custom_routing_accelerators.ListCustomRoutingAcceleratorsOutput {
        return list_custom_routing_accelerators.execute(self, allocator, input, options);
    }

    /// List the endpoint groups that are associated with a listener for a custom
    /// routing accelerator.
    pub fn listCustomRoutingEndpointGroups(self: *Self, allocator: std.mem.Allocator, input: list_custom_routing_endpoint_groups.ListCustomRoutingEndpointGroupsInput, options: CallOptions) !list_custom_routing_endpoint_groups.ListCustomRoutingEndpointGroupsOutput {
        return list_custom_routing_endpoint_groups.execute(self, allocator, input, options);
    }

    /// List the listeners for a custom routing accelerator.
    pub fn listCustomRoutingListeners(self: *Self, allocator: std.mem.Allocator, input: list_custom_routing_listeners.ListCustomRoutingListenersInput, options: CallOptions) !list_custom_routing_listeners.ListCustomRoutingListenersOutput {
        return list_custom_routing_listeners.execute(self, allocator, input, options);
    }

    /// Provides a complete mapping from the public accelerator IP address and port
    /// to destination EC2 instance
    /// IP addresses and ports in the virtual public cloud (VPC) subnet endpoint for
    /// a custom routing accelerator.
    /// For each subnet endpoint that you add, Global Accelerator creates a new
    /// static port mapping for the accelerator. The port
    /// mappings don't change after Global Accelerator generates them, so you can
    /// retrieve and cache the full mapping on your servers.
    ///
    /// If you remove a subnet from your accelerator, Global Accelerator removes
    /// (reclaims) the port mappings. If you add a subnet to
    /// your accelerator, Global Accelerator creates new port mappings (the existing
    /// ones don't change). If you add or remove EC2 instances
    /// in your subnet, the port mappings don't change, because the mappings are
    /// created when you add the subnet to Global Accelerator.
    ///
    /// The mappings also include a flag for each destination denoting which
    /// destination IP addresses and
    /// ports are allowed or denied traffic.
    pub fn listCustomRoutingPortMappings(self: *Self, allocator: std.mem.Allocator, input: list_custom_routing_port_mappings.ListCustomRoutingPortMappingsInput, options: CallOptions) !list_custom_routing_port_mappings.ListCustomRoutingPortMappingsOutput {
        return list_custom_routing_port_mappings.execute(self, allocator, input, options);
    }

    /// List the port mappings for a specific EC2 instance (destination) in a VPC
    /// subnet endpoint. The
    /// response is the mappings for one destination IP address. This is useful when
    /// your subnet endpoint has mappings that
    /// span multiple custom routing accelerators in your account, or for scenarios
    /// where you only want to
    /// list the port mappings for a specific destination instance.
    pub fn listCustomRoutingPortMappingsByDestination(self: *Self, allocator: std.mem.Allocator, input: list_custom_routing_port_mappings_by_destination.ListCustomRoutingPortMappingsByDestinationInput, options: CallOptions) !list_custom_routing_port_mappings_by_destination.ListCustomRoutingPortMappingsByDestinationOutput {
        return list_custom_routing_port_mappings_by_destination.execute(self, allocator, input, options);
    }

    /// List the endpoint groups that are associated with a listener.
    pub fn listEndpointGroups(self: *Self, allocator: std.mem.Allocator, input: list_endpoint_groups.ListEndpointGroupsInput, options: CallOptions) !list_endpoint_groups.ListEndpointGroupsOutput {
        return list_endpoint_groups.execute(self, allocator, input, options);
    }

    /// List the listeners for an accelerator.
    pub fn listListeners(self: *Self, allocator: std.mem.Allocator, input: list_listeners.ListListenersInput, options: CallOptions) !list_listeners.ListListenersOutput {
        return list_listeners.execute(self, allocator, input, options);
    }

    /// List all tags for an accelerator.
    ///
    /// For more information, see [Tagging
    /// in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/tagging-in-global-accelerator.html) in the *Global Accelerator Developer Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Provisions an IP address range to use with your Amazon Web Services
    /// resources through bring your own IP
    /// addresses (BYOIP) and creates a corresponding address pool. After the
    /// address range is provisioned,
    /// it is ready to be advertised using [
    /// AdvertiseByoipCidr](https://docs.aws.amazon.com/global-accelerator/latest/api/AdvertiseByoipCidr.html).
    ///
    /// For more information, see [Bring your own
    /// IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
    pub fn provisionByoipCidr(self: *Self, allocator: std.mem.Allocator, input: provision_byoip_cidr.ProvisionByoipCidrInput, options: CallOptions) !provision_byoip_cidr.ProvisionByoipCidrOutput {
        return provision_byoip_cidr.execute(self, allocator, input, options);
    }

    /// Remove endpoints from a custom routing accelerator.
    pub fn removeCustomRoutingEndpoints(self: *Self, allocator: std.mem.Allocator, input: remove_custom_routing_endpoints.RemoveCustomRoutingEndpointsInput, options: CallOptions) !remove_custom_routing_endpoints.RemoveCustomRoutingEndpointsOutput {
        return remove_custom_routing_endpoints.execute(self, allocator, input, options);
    }

    /// Remove endpoints from an endpoint group.
    ///
    /// The `RemoveEndpoints` API operation is the recommended option for removing
    /// endpoints. The alternative is to remove
    /// endpoints by updating an endpoint group by using the
    /// [UpdateEndpointGroup](https://docs.aws.amazon.com/global-accelerator/latest/api/API_UpdateEndpointGroup.html)
    /// API operation. There are two advantages to using `AddEndpoints` to remove
    /// endpoints instead:
    ///
    /// * It's more convenient, because you only need to specify the endpoints that
    ///   you want to remove. With the
    /// `UpdateEndpointGroup` API operation, you must specify all of the endpoints
    /// in the
    /// endpoint group except the ones that you want to remove from the group.
    ///
    /// * It's faster, because Global Accelerator doesn't need to resolve any
    ///   endpoints. With the
    /// `UpdateEndpointGroup` API operation, Global Accelerator must resolve all of
    /// the endpoints that
    /// remain in the group.
    pub fn removeEndpoints(self: *Self, allocator: std.mem.Allocator, input: remove_endpoints.RemoveEndpointsInput, options: CallOptions) !remove_endpoints.RemoveEndpointsOutput {
        return remove_endpoints.execute(self, allocator, input, options);
    }

    /// Add tags to an accelerator resource.
    ///
    /// For more information, see [Tagging
    /// in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/tagging-in-global-accelerator.html) in the *Global Accelerator Developer Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove tags from a Global Accelerator resource. When you specify a tag key,
    /// the action removes both that key and its associated value.
    /// The operation succeeds even if you attempt to remove tags from an
    /// accelerator that was already removed.
    ///
    /// For more information, see [Tagging
    /// in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/tagging-in-global-accelerator.html) in the *Global Accelerator Developer Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update an accelerator to make changes, such as the following:
    ///
    /// * Change the name of the accelerator.
    ///
    /// * Disable the accelerator so that it no longer accepts or routes traffic, or
    ///   so that you can delete it.
    ///
    /// * Enable the accelerator, if it is disabled.
    ///
    /// * Change the IP address type to dual-stack if it is IPv4, or change the IP
    ///   address type to IPv4 if it's dual-stack.
    ///
    /// Be aware that static IP addresses remain assigned to your accelerator for as
    /// long as it exists, even if you disable the accelerator and it no
    /// longer accepts or routes traffic. However, when you delete the accelerator,
    /// you lose the static IP addresses that are assigned to it, so you
    /// can no longer route traffic by using them.
    ///
    /// Global Accelerator is a global service that supports endpoints in multiple
    /// Amazon Web Services Regions but you must specify the
    /// US West (Oregon) Region to create, update, or otherwise work with
    /// accelerators. That is, for example, specify `--region us-west-2`
    /// on Amazon Web Services CLI commands.
    pub fn updateAccelerator(self: *Self, allocator: std.mem.Allocator, input: update_accelerator.UpdateAcceleratorInput, options: CallOptions) !update_accelerator.UpdateAcceleratorOutput {
        return update_accelerator.execute(self, allocator, input, options);
    }

    /// Update the attributes for an accelerator.
    pub fn updateAcceleratorAttributes(self: *Self, allocator: std.mem.Allocator, input: update_accelerator_attributes.UpdateAcceleratorAttributesInput, options: CallOptions) !update_accelerator_attributes.UpdateAcceleratorAttributesOutput {
        return update_accelerator_attributes.execute(self, allocator, input, options);
    }

    /// Update a cross-account attachment to add or remove principals or resources.
    /// When you update
    /// an attachment to remove a principal (account ID or accelerator) or a
    /// resource, Global Accelerator
    /// revokes the permission for specific resources.
    ///
    /// For more information, see [
    /// Working with cross-account attachments and resources in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/cross-account-resources.html) in the *
    /// Global Accelerator Developer Guide*.
    pub fn updateCrossAccountAttachment(self: *Self, allocator: std.mem.Allocator, input: update_cross_account_attachment.UpdateCrossAccountAttachmentInput, options: CallOptions) !update_cross_account_attachment.UpdateCrossAccountAttachmentOutput {
        return update_cross_account_attachment.execute(self, allocator, input, options);
    }

    /// Update a custom routing accelerator.
    pub fn updateCustomRoutingAccelerator(self: *Self, allocator: std.mem.Allocator, input: update_custom_routing_accelerator.UpdateCustomRoutingAcceleratorInput, options: CallOptions) !update_custom_routing_accelerator.UpdateCustomRoutingAcceleratorOutput {
        return update_custom_routing_accelerator.execute(self, allocator, input, options);
    }

    /// Update the attributes for a custom routing accelerator.
    pub fn updateCustomRoutingAcceleratorAttributes(self: *Self, allocator: std.mem.Allocator, input: update_custom_routing_accelerator_attributes.UpdateCustomRoutingAcceleratorAttributesInput, options: CallOptions) !update_custom_routing_accelerator_attributes.UpdateCustomRoutingAcceleratorAttributesOutput {
        return update_custom_routing_accelerator_attributes.execute(self, allocator, input, options);
    }

    /// Update a listener for a custom routing accelerator.
    pub fn updateCustomRoutingListener(self: *Self, allocator: std.mem.Allocator, input: update_custom_routing_listener.UpdateCustomRoutingListenerInput, options: CallOptions) !update_custom_routing_listener.UpdateCustomRoutingListenerOutput {
        return update_custom_routing_listener.execute(self, allocator, input, options);
    }

    /// Update an endpoint group. A resource must be valid and active when you add
    /// it as an endpoint.
    pub fn updateEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: update_endpoint_group.UpdateEndpointGroupInput, options: CallOptions) !update_endpoint_group.UpdateEndpointGroupOutput {
        return update_endpoint_group.execute(self, allocator, input, options);
    }

    /// Update a listener.
    pub fn updateListener(self: *Self, allocator: std.mem.Allocator, input: update_listener.UpdateListenerInput, options: CallOptions) !update_listener.UpdateListenerOutput {
        return update_listener.execute(self, allocator, input, options);
    }

    /// Stops advertising an address range that is provisioned as an address pool.
    /// You can perform this operation at most once every 10 seconds, even if you
    /// specify different address
    /// ranges each time.
    ///
    /// It can take a few minutes before traffic to the specified addresses stops
    /// routing to Amazon Web Services because of
    /// propagation delays.
    ///
    /// For more information, see [Bring your own
    /// IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
    pub fn withdrawByoipCidr(self: *Self, allocator: std.mem.Allocator, input: withdraw_byoip_cidr.WithdrawByoipCidrInput, options: CallOptions) !withdraw_byoip_cidr.WithdrawByoipCidrOutput {
        return withdraw_byoip_cidr.execute(self, allocator, input, options);
    }

    pub fn listAcceleratorsPaginator(self: *Self, params: list_accelerators.ListAcceleratorsInput) paginator.ListAcceleratorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listByoipCidrsPaginator(self: *Self, params: list_byoip_cidrs.ListByoipCidrsInput) paginator.ListByoipCidrsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCrossAccountAttachmentsPaginator(self: *Self, params: list_cross_account_attachments.ListCrossAccountAttachmentsInput) paginator.ListCrossAccountAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCrossAccountResourcesPaginator(self: *Self, params: list_cross_account_resources.ListCrossAccountResourcesInput) paginator.ListCrossAccountResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomRoutingAcceleratorsPaginator(self: *Self, params: list_custom_routing_accelerators.ListCustomRoutingAcceleratorsInput) paginator.ListCustomRoutingAcceleratorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomRoutingEndpointGroupsPaginator(self: *Self, params: list_custom_routing_endpoint_groups.ListCustomRoutingEndpointGroupsInput) paginator.ListCustomRoutingEndpointGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomRoutingListenersPaginator(self: *Self, params: list_custom_routing_listeners.ListCustomRoutingListenersInput) paginator.ListCustomRoutingListenersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomRoutingPortMappingsPaginator(self: *Self, params: list_custom_routing_port_mappings.ListCustomRoutingPortMappingsInput) paginator.ListCustomRoutingPortMappingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCustomRoutingPortMappingsByDestinationPaginator(self: *Self, params: list_custom_routing_port_mappings_by_destination.ListCustomRoutingPortMappingsByDestinationInput) paginator.ListCustomRoutingPortMappingsByDestinationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEndpointGroupsPaginator(self: *Self, params: list_endpoint_groups.ListEndpointGroupsInput) paginator.ListEndpointGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listListenersPaginator(self: *Self, params: list_listeners.ListListenersInput) paginator.ListListenersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
