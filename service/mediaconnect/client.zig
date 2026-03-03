const aws = @import("aws");
const std = @import("std");

const add_bridge_outputs = @import("add_bridge_outputs.zig");
const add_bridge_sources = @import("add_bridge_sources.zig");
const add_flow_media_streams = @import("add_flow_media_streams.zig");
const add_flow_outputs = @import("add_flow_outputs.zig");
const add_flow_sources = @import("add_flow_sources.zig");
const add_flow_vpc_interfaces = @import("add_flow_vpc_interfaces.zig");
const batch_get_router_input = @import("batch_get_router_input.zig");
const batch_get_router_network_interface = @import("batch_get_router_network_interface.zig");
const batch_get_router_output = @import("batch_get_router_output.zig");
const create_bridge = @import("create_bridge.zig");
const create_flow = @import("create_flow.zig");
const create_gateway = @import("create_gateway.zig");
const create_router_input = @import("create_router_input.zig");
const create_router_network_interface = @import("create_router_network_interface.zig");
const create_router_output = @import("create_router_output.zig");
const delete_bridge = @import("delete_bridge.zig");
const delete_flow = @import("delete_flow.zig");
const delete_gateway = @import("delete_gateway.zig");
const delete_router_input = @import("delete_router_input.zig");
const delete_router_network_interface = @import("delete_router_network_interface.zig");
const delete_router_output = @import("delete_router_output.zig");
const deregister_gateway_instance = @import("deregister_gateway_instance.zig");
const describe_bridge = @import("describe_bridge.zig");
const describe_flow = @import("describe_flow.zig");
const describe_flow_source_metadata = @import("describe_flow_source_metadata.zig");
const describe_flow_source_thumbnail = @import("describe_flow_source_thumbnail.zig");
const describe_gateway = @import("describe_gateway.zig");
const describe_gateway_instance = @import("describe_gateway_instance.zig");
const describe_offering = @import("describe_offering.zig");
const describe_reservation = @import("describe_reservation.zig");
const get_router_input = @import("get_router_input.zig");
const get_router_input_source_metadata = @import("get_router_input_source_metadata.zig");
const get_router_input_thumbnail = @import("get_router_input_thumbnail.zig");
const get_router_network_interface = @import("get_router_network_interface.zig");
const get_router_output = @import("get_router_output.zig");
const grant_flow_entitlements = @import("grant_flow_entitlements.zig");
const list_bridges = @import("list_bridges.zig");
const list_entitlements = @import("list_entitlements.zig");
const list_flows = @import("list_flows.zig");
const list_gateway_instances = @import("list_gateway_instances.zig");
const list_gateways = @import("list_gateways.zig");
const list_offerings = @import("list_offerings.zig");
const list_reservations = @import("list_reservations.zig");
const list_router_inputs = @import("list_router_inputs.zig");
const list_router_network_interfaces = @import("list_router_network_interfaces.zig");
const list_router_outputs = @import("list_router_outputs.zig");
const list_tags_for_global_resource = @import("list_tags_for_global_resource.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const purchase_offering = @import("purchase_offering.zig");
const remove_bridge_output = @import("remove_bridge_output.zig");
const remove_bridge_source = @import("remove_bridge_source.zig");
const remove_flow_media_stream = @import("remove_flow_media_stream.zig");
const remove_flow_output = @import("remove_flow_output.zig");
const remove_flow_source = @import("remove_flow_source.zig");
const remove_flow_vpc_interface = @import("remove_flow_vpc_interface.zig");
const restart_router_input = @import("restart_router_input.zig");
const restart_router_output = @import("restart_router_output.zig");
const revoke_flow_entitlement = @import("revoke_flow_entitlement.zig");
const start_flow = @import("start_flow.zig");
const start_router_input = @import("start_router_input.zig");
const start_router_output = @import("start_router_output.zig");
const stop_flow = @import("stop_flow.zig");
const stop_router_input = @import("stop_router_input.zig");
const stop_router_output = @import("stop_router_output.zig");
const tag_global_resource = @import("tag_global_resource.zig");
const tag_resource = @import("tag_resource.zig");
const take_router_input = @import("take_router_input.zig");
const untag_global_resource = @import("untag_global_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_bridge = @import("update_bridge.zig");
const update_bridge_output = @import("update_bridge_output.zig");
const update_bridge_source = @import("update_bridge_source.zig");
const update_bridge_state = @import("update_bridge_state.zig");
const update_flow = @import("update_flow.zig");
const update_flow_entitlement = @import("update_flow_entitlement.zig");
const update_flow_media_stream = @import("update_flow_media_stream.zig");
const update_flow_output = @import("update_flow_output.zig");
const update_flow_source = @import("update_flow_source.zig");
const update_gateway_instance = @import("update_gateway_instance.zig");
const update_router_input = @import("update_router_input.zig");
const update_router_network_interface = @import("update_router_network_interface.zig");
const update_router_output = @import("update_router_output.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaConnect";

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

    /// Adds outputs to an existing bridge.
    pub fn addBridgeOutputs(self: *Self, allocator: std.mem.Allocator, input: add_bridge_outputs.AddBridgeOutputsInput, options: CallOptions) !add_bridge_outputs.AddBridgeOutputsOutput {
        return add_bridge_outputs.execute(self, allocator, input, options);
    }

    /// Adds sources to an existing bridge.
    pub fn addBridgeSources(self: *Self, allocator: std.mem.Allocator, input: add_bridge_sources.AddBridgeSourcesInput, options: CallOptions) !add_bridge_sources.AddBridgeSourcesOutput {
        return add_bridge_sources.execute(self, allocator, input, options);
    }

    /// Adds media streams to an existing flow. After you add a media stream to a
    /// flow, you can associate it with a source and/or an output that uses the ST
    /// 2110 JPEG XS or CDI protocol.
    pub fn addFlowMediaStreams(self: *Self, allocator: std.mem.Allocator, input: add_flow_media_streams.AddFlowMediaStreamsInput, options: CallOptions) !add_flow_media_streams.AddFlowMediaStreamsOutput {
        return add_flow_media_streams.execute(self, allocator, input, options);
    }

    /// Adds outputs to an existing flow. You can create up to 50 outputs per flow.
    pub fn addFlowOutputs(self: *Self, allocator: std.mem.Allocator, input: add_flow_outputs.AddFlowOutputsInput, options: CallOptions) !add_flow_outputs.AddFlowOutputsOutput {
        return add_flow_outputs.execute(self, allocator, input, options);
    }

    /// Adds sources to a flow.
    pub fn addFlowSources(self: *Self, allocator: std.mem.Allocator, input: add_flow_sources.AddFlowSourcesInput, options: CallOptions) !add_flow_sources.AddFlowSourcesOutput {
        return add_flow_sources.execute(self, allocator, input, options);
    }

    /// Adds VPC interfaces to a flow.
    pub fn addFlowVpcInterfaces(self: *Self, allocator: std.mem.Allocator, input: add_flow_vpc_interfaces.AddFlowVpcInterfacesInput, options: CallOptions) !add_flow_vpc_interfaces.AddFlowVpcInterfacesOutput {
        return add_flow_vpc_interfaces.execute(self, allocator, input, options);
    }

    /// Retrieves information about multiple router inputs in AWS Elemental
    /// MediaConnect.
    pub fn batchGetRouterInput(self: *Self, allocator: std.mem.Allocator, input: batch_get_router_input.BatchGetRouterInputInput, options: CallOptions) !batch_get_router_input.BatchGetRouterInputOutput {
        return batch_get_router_input.execute(self, allocator, input, options);
    }

    /// Retrieves information about multiple router network interfaces in AWS
    /// Elemental MediaConnect.
    pub fn batchGetRouterNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: batch_get_router_network_interface.BatchGetRouterNetworkInterfaceInput, options: CallOptions) !batch_get_router_network_interface.BatchGetRouterNetworkInterfaceOutput {
        return batch_get_router_network_interface.execute(self, allocator, input, options);
    }

    /// Retrieves information about multiple router outputs in AWS Elemental
    /// MediaConnect.
    pub fn batchGetRouterOutput(self: *Self, allocator: std.mem.Allocator, input: batch_get_router_output.BatchGetRouterOutputInput, options: CallOptions) !batch_get_router_output.BatchGetRouterOutputOutput {
        return batch_get_router_output.execute(self, allocator, input, options);
    }

    /// Creates a new bridge. The request must include one source.
    pub fn createBridge(self: *Self, allocator: std.mem.Allocator, input: create_bridge.CreateBridgeInput, options: CallOptions) !create_bridge.CreateBridgeOutput {
        return create_bridge.execute(self, allocator, input, options);
    }

    /// Creates a new flow. The request must include one source. The request
    /// optionally can include outputs (up to 50) and entitlements (up to 50).
    pub fn createFlow(self: *Self, allocator: std.mem.Allocator, input: create_flow.CreateFlowInput, options: CallOptions) !create_flow.CreateFlowOutput {
        return create_flow.execute(self, allocator, input, options);
    }

    /// Creates a new gateway. The request must include at least one network (up to
    /// four).
    pub fn createGateway(self: *Self, allocator: std.mem.Allocator, input: create_gateway.CreateGatewayInput, options: CallOptions) !create_gateway.CreateGatewayOutput {
        return create_gateway.execute(self, allocator, input, options);
    }

    /// Creates a new router input in AWS Elemental MediaConnect.
    pub fn createRouterInput(self: *Self, allocator: std.mem.Allocator, input: create_router_input.CreateRouterInputInput, options: CallOptions) !create_router_input.CreateRouterInputOutput {
        return create_router_input.execute(self, allocator, input, options);
    }

    /// Creates a new router network interface in AWS Elemental MediaConnect.
    pub fn createRouterNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: create_router_network_interface.CreateRouterNetworkInterfaceInput, options: CallOptions) !create_router_network_interface.CreateRouterNetworkInterfaceOutput {
        return create_router_network_interface.execute(self, allocator, input, options);
    }

    /// Creates a new router output in AWS Elemental MediaConnect.
    pub fn createRouterOutput(self: *Self, allocator: std.mem.Allocator, input: create_router_output.CreateRouterOutputInput, options: CallOptions) !create_router_output.CreateRouterOutputOutput {
        return create_router_output.execute(self, allocator, input, options);
    }

    /// Deletes a bridge. Before you can delete a bridge, you must stop the bridge.
    pub fn deleteBridge(self: *Self, allocator: std.mem.Allocator, input: delete_bridge.DeleteBridgeInput, options: CallOptions) !delete_bridge.DeleteBridgeOutput {
        return delete_bridge.execute(self, allocator, input, options);
    }

    /// Deletes a flow. Before you can delete a flow, you must stop the flow.
    pub fn deleteFlow(self: *Self, allocator: std.mem.Allocator, input: delete_flow.DeleteFlowInput, options: CallOptions) !delete_flow.DeleteFlowOutput {
        return delete_flow.execute(self, allocator, input, options);
    }

    /// Deletes a gateway. Before you can delete a gateway, you must deregister its
    /// instances and delete its bridges.
    pub fn deleteGateway(self: *Self, allocator: std.mem.Allocator, input: delete_gateway.DeleteGatewayInput, options: CallOptions) !delete_gateway.DeleteGatewayOutput {
        return delete_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a router input from AWS Elemental MediaConnect.
    pub fn deleteRouterInput(self: *Self, allocator: std.mem.Allocator, input: delete_router_input.DeleteRouterInputInput, options: CallOptions) !delete_router_input.DeleteRouterInputOutput {
        return delete_router_input.execute(self, allocator, input, options);
    }

    /// Deletes a router network interface from AWS Elemental MediaConnect.
    pub fn deleteRouterNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: delete_router_network_interface.DeleteRouterNetworkInterfaceInput, options: CallOptions) !delete_router_network_interface.DeleteRouterNetworkInterfaceOutput {
        return delete_router_network_interface.execute(self, allocator, input, options);
    }

    /// Deletes a router output from AWS Elemental MediaConnect.
    pub fn deleteRouterOutput(self: *Self, allocator: std.mem.Allocator, input: delete_router_output.DeleteRouterOutputInput, options: CallOptions) !delete_router_output.DeleteRouterOutputOutput {
        return delete_router_output.execute(self, allocator, input, options);
    }

    /// Deregisters an instance. Before you deregister an instance, all bridges
    /// running on the instance must be stopped. If you want to deregister an
    /// instance without stopping the bridges, you must use the --force option.
    pub fn deregisterGatewayInstance(self: *Self, allocator: std.mem.Allocator, input: deregister_gateway_instance.DeregisterGatewayInstanceInput, options: CallOptions) !deregister_gateway_instance.DeregisterGatewayInstanceOutput {
        return deregister_gateway_instance.execute(self, allocator, input, options);
    }

    /// Displays the details of a bridge.
    pub fn describeBridge(self: *Self, allocator: std.mem.Allocator, input: describe_bridge.DescribeBridgeInput, options: CallOptions) !describe_bridge.DescribeBridgeOutput {
        return describe_bridge.execute(self, allocator, input, options);
    }

    /// Displays the details of a flow. The response includes the flow Amazon
    /// Resource Name (ARN), name, and Availability Zone, as well as details about
    /// the source, outputs, and entitlements.
    pub fn describeFlow(self: *Self, allocator: std.mem.Allocator, input: describe_flow.DescribeFlowInput, options: CallOptions) !describe_flow.DescribeFlowOutput {
        return describe_flow.execute(self, allocator, input, options);
    }

    /// The `DescribeFlowSourceMetadata` API is used to view information about the
    /// flow's source transport stream and programs. This API displays status
    /// messages about the flow's source as well as details about the program's
    /// video, audio, and other data.
    pub fn describeFlowSourceMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_flow_source_metadata.DescribeFlowSourceMetadataInput, options: CallOptions) !describe_flow_source_metadata.DescribeFlowSourceMetadataOutput {
        return describe_flow_source_metadata.execute(self, allocator, input, options);
    }

    /// Describes the thumbnail for the flow source.
    pub fn describeFlowSourceThumbnail(self: *Self, allocator: std.mem.Allocator, input: describe_flow_source_thumbnail.DescribeFlowSourceThumbnailInput, options: CallOptions) !describe_flow_source_thumbnail.DescribeFlowSourceThumbnailOutput {
        return describe_flow_source_thumbnail.execute(self, allocator, input, options);
    }

    /// Displays the details of a gateway. The response includes the gateway Amazon
    /// Resource Name (ARN), name, and CIDR blocks, as well as details about the
    /// networks.
    pub fn describeGateway(self: *Self, allocator: std.mem.Allocator, input: describe_gateway.DescribeGatewayInput, options: CallOptions) !describe_gateway.DescribeGatewayOutput {
        return describe_gateway.execute(self, allocator, input, options);
    }

    /// Displays the details of an instance.
    pub fn describeGatewayInstance(self: *Self, allocator: std.mem.Allocator, input: describe_gateway_instance.DescribeGatewayInstanceInput, options: CallOptions) !describe_gateway_instance.DescribeGatewayInstanceOutput {
        return describe_gateway_instance.execute(self, allocator, input, options);
    }

    /// Displays the details of an offering. The response includes the offering
    /// description, duration, outbound bandwidth, price, and Amazon Resource Name
    /// (ARN).
    pub fn describeOffering(self: *Self, allocator: std.mem.Allocator, input: describe_offering.DescribeOfferingInput, options: CallOptions) !describe_offering.DescribeOfferingOutput {
        return describe_offering.execute(self, allocator, input, options);
    }

    /// Displays the details of a reservation. The response includes the reservation
    /// name, state, start date and time, and the details of the offering that make
    /// up the rest of the reservation (such as price, duration, and outbound
    /// bandwidth).
    pub fn describeReservation(self: *Self, allocator: std.mem.Allocator, input: describe_reservation.DescribeReservationInput, options: CallOptions) !describe_reservation.DescribeReservationOutput {
        return describe_reservation.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific router input in AWS Elemental
    /// MediaConnect.
    pub fn getRouterInput(self: *Self, allocator: std.mem.Allocator, input: get_router_input.GetRouterInputInput, options: CallOptions) !get_router_input.GetRouterInputOutput {
        return get_router_input.execute(self, allocator, input, options);
    }

    /// Retrieves detailed metadata information about a specific router input
    /// source, including stream details and connection state.
    pub fn getRouterInputSourceMetadata(self: *Self, allocator: std.mem.Allocator, input: get_router_input_source_metadata.GetRouterInputSourceMetadataInput, options: CallOptions) !get_router_input_source_metadata.GetRouterInputSourceMetadataOutput {
        return get_router_input_source_metadata.execute(self, allocator, input, options);
    }

    /// Retrieves the thumbnail for a router input in AWS Elemental MediaConnect.
    pub fn getRouterInputThumbnail(self: *Self, allocator: std.mem.Allocator, input: get_router_input_thumbnail.GetRouterInputThumbnailInput, options: CallOptions) !get_router_input_thumbnail.GetRouterInputThumbnailOutput {
        return get_router_input_thumbnail.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific router network interface in AWS
    /// Elemental MediaConnect.
    pub fn getRouterNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: get_router_network_interface.GetRouterNetworkInterfaceInput, options: CallOptions) !get_router_network_interface.GetRouterNetworkInterfaceOutput {
        return get_router_network_interface.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific router output in AWS Elemental
    /// MediaConnect.
    pub fn getRouterOutput(self: *Self, allocator: std.mem.Allocator, input: get_router_output.GetRouterOutputInput, options: CallOptions) !get_router_output.GetRouterOutputOutput {
        return get_router_output.execute(self, allocator, input, options);
    }

    /// Grants entitlements to an existing flow.
    pub fn grantFlowEntitlements(self: *Self, allocator: std.mem.Allocator, input: grant_flow_entitlements.GrantFlowEntitlementsInput, options: CallOptions) !grant_flow_entitlements.GrantFlowEntitlementsOutput {
        return grant_flow_entitlements.execute(self, allocator, input, options);
    }

    /// Displays a list of bridges that are associated with this account and an
    /// optionally specified Amazon Resource Name (ARN). This request returns a
    /// paginated result.
    pub fn listBridges(self: *Self, allocator: std.mem.Allocator, input: list_bridges.ListBridgesInput, options: CallOptions) !list_bridges.ListBridgesOutput {
        return list_bridges.execute(self, allocator, input, options);
    }

    /// Displays a list of all entitlements that have been granted to this account.
    /// This request returns 20 results per page.
    pub fn listEntitlements(self: *Self, allocator: std.mem.Allocator, input: list_entitlements.ListEntitlementsInput, options: CallOptions) !list_entitlements.ListEntitlementsOutput {
        return list_entitlements.execute(self, allocator, input, options);
    }

    /// Displays a list of flows that are associated with this account. This request
    /// returns a paginated result.
    pub fn listFlows(self: *Self, allocator: std.mem.Allocator, input: list_flows.ListFlowsInput, options: CallOptions) !list_flows.ListFlowsOutput {
        return list_flows.execute(self, allocator, input, options);
    }

    /// Displays a list of instances associated with the Amazon Web Services
    /// account. This request returns a paginated result. You can use the filterArn
    /// property to display only the instances associated with the selected Gateway
    /// Amazon Resource Name (ARN).
    pub fn listGatewayInstances(self: *Self, allocator: std.mem.Allocator, input: list_gateway_instances.ListGatewayInstancesInput, options: CallOptions) !list_gateway_instances.ListGatewayInstancesOutput {
        return list_gateway_instances.execute(self, allocator, input, options);
    }

    /// Displays a list of gateways that are associated with this account. This
    /// request returns a paginated result.
    pub fn listGateways(self: *Self, allocator: std.mem.Allocator, input: list_gateways.ListGatewaysInput, options: CallOptions) !list_gateways.ListGatewaysOutput {
        return list_gateways.execute(self, allocator, input, options);
    }

    /// Displays a list of all offerings that are available to this account in the
    /// current Amazon Web Services Region. If you have an active reservation (which
    /// means you've purchased an offering that has already started and hasn't
    /// expired yet), your account isn't eligible for other offerings.
    pub fn listOfferings(self: *Self, allocator: std.mem.Allocator, input: list_offerings.ListOfferingsInput, options: CallOptions) !list_offerings.ListOfferingsOutput {
        return list_offerings.execute(self, allocator, input, options);
    }

    /// Displays a list of all reservations that have been purchased by this account
    /// in the current Amazon Web Services Region. This list includes all
    /// reservations in all states (such as active and expired).
    pub fn listReservations(self: *Self, allocator: std.mem.Allocator, input: list_reservations.ListReservationsInput, options: CallOptions) !list_reservations.ListReservationsOutput {
        return list_reservations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of router inputs in AWS Elemental MediaConnect.
    pub fn listRouterInputs(self: *Self, allocator: std.mem.Allocator, input: list_router_inputs.ListRouterInputsInput, options: CallOptions) !list_router_inputs.ListRouterInputsOutput {
        return list_router_inputs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of router network interfaces in AWS Elemental MediaConnect.
    pub fn listRouterNetworkInterfaces(self: *Self, allocator: std.mem.Allocator, input: list_router_network_interfaces.ListRouterNetworkInterfacesInput, options: CallOptions) !list_router_network_interfaces.ListRouterNetworkInterfacesOutput {
        return list_router_network_interfaces.execute(self, allocator, input, options);
    }

    /// Retrieves a list of router outputs in AWS Elemental MediaConnect.
    pub fn listRouterOutputs(self: *Self, allocator: std.mem.Allocator, input: list_router_outputs.ListRouterOutputsInput, options: CallOptions) !list_router_outputs.ListRouterOutputsOutput {
        return list_router_outputs.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with a global resource in AWS Elemental
    /// MediaConnect. The API supports the following global resources: router
    /// inputs, router outputs and router network interfaces.
    pub fn listTagsForGlobalResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_global_resource.ListTagsForGlobalResourceInput, options: CallOptions) !list_tags_for_global_resource.ListTagsForGlobalResourceOutput {
        return list_tags_for_global_resource.execute(self, allocator, input, options);
    }

    /// List all tags on a MediaConnect resource in the current region.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Submits a request to purchase an offering. If you already have an active
    /// reservation, you can't purchase another offering.
    pub fn purchaseOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_offering.PurchaseOfferingInput, options: CallOptions) !purchase_offering.PurchaseOfferingOutput {
        return purchase_offering.execute(self, allocator, input, options);
    }

    /// Removes an output from a bridge.
    pub fn removeBridgeOutput(self: *Self, allocator: std.mem.Allocator, input: remove_bridge_output.RemoveBridgeOutputInput, options: CallOptions) !remove_bridge_output.RemoveBridgeOutputOutput {
        return remove_bridge_output.execute(self, allocator, input, options);
    }

    /// Removes a source from a bridge.
    pub fn removeBridgeSource(self: *Self, allocator: std.mem.Allocator, input: remove_bridge_source.RemoveBridgeSourceInput, options: CallOptions) !remove_bridge_source.RemoveBridgeSourceOutput {
        return remove_bridge_source.execute(self, allocator, input, options);
    }

    /// Removes a media stream from a flow. This action is only available if the
    /// media stream is not associated with a source or output.
    pub fn removeFlowMediaStream(self: *Self, allocator: std.mem.Allocator, input: remove_flow_media_stream.RemoveFlowMediaStreamInput, options: CallOptions) !remove_flow_media_stream.RemoveFlowMediaStreamOutput {
        return remove_flow_media_stream.execute(self, allocator, input, options);
    }

    /// Removes an output from an existing flow. This request can be made only on an
    /// output that does not have an entitlement associated with it. If the output
    /// has an entitlement, you must revoke the entitlement instead. When an
    /// entitlement is revoked from a flow, the service automatically removes the
    /// associated output.
    pub fn removeFlowOutput(self: *Self, allocator: std.mem.Allocator, input: remove_flow_output.RemoveFlowOutputInput, options: CallOptions) !remove_flow_output.RemoveFlowOutputOutput {
        return remove_flow_output.execute(self, allocator, input, options);
    }

    /// Removes a source from an existing flow. This request can be made only if
    /// there is more than one source on the flow.
    pub fn removeFlowSource(self: *Self, allocator: std.mem.Allocator, input: remove_flow_source.RemoveFlowSourceInput, options: CallOptions) !remove_flow_source.RemoveFlowSourceOutput {
        return remove_flow_source.execute(self, allocator, input, options);
    }

    /// Removes a VPC Interface from an existing flow. This request can be made only
    /// on a VPC interface that does not have a Source or Output associated with it.
    /// If the VPC interface is referenced by a Source or Output, you must first
    /// delete or update the Source or Output to no longer reference the VPC
    /// interface.
    pub fn removeFlowVpcInterface(self: *Self, allocator: std.mem.Allocator, input: remove_flow_vpc_interface.RemoveFlowVpcInterfaceInput, options: CallOptions) !remove_flow_vpc_interface.RemoveFlowVpcInterfaceOutput {
        return remove_flow_vpc_interface.execute(self, allocator, input, options);
    }

    /// Restarts a router input. This operation can be used to recover from errors
    /// or refresh the input state.
    pub fn restartRouterInput(self: *Self, allocator: std.mem.Allocator, input: restart_router_input.RestartRouterInputInput, options: CallOptions) !restart_router_input.RestartRouterInputOutput {
        return restart_router_input.execute(self, allocator, input, options);
    }

    /// Restarts a router output. This operation can be used to recover from errors
    /// or refresh the output state.
    pub fn restartRouterOutput(self: *Self, allocator: std.mem.Allocator, input: restart_router_output.RestartRouterOutputInput, options: CallOptions) !restart_router_output.RestartRouterOutputOutput {
        return restart_router_output.execute(self, allocator, input, options);
    }

    /// Revokes an entitlement from a flow. Once an entitlement is revoked, the
    /// content becomes unavailable to the subscriber and the associated output is
    /// removed.
    pub fn revokeFlowEntitlement(self: *Self, allocator: std.mem.Allocator, input: revoke_flow_entitlement.RevokeFlowEntitlementInput, options: CallOptions) !revoke_flow_entitlement.RevokeFlowEntitlementOutput {
        return revoke_flow_entitlement.execute(self, allocator, input, options);
    }

    /// Starts a flow.
    pub fn startFlow(self: *Self, allocator: std.mem.Allocator, input: start_flow.StartFlowInput, options: CallOptions) !start_flow.StartFlowOutput {
        return start_flow.execute(self, allocator, input, options);
    }

    /// Starts a router input in AWS Elemental MediaConnect.
    pub fn startRouterInput(self: *Self, allocator: std.mem.Allocator, input: start_router_input.StartRouterInputInput, options: CallOptions) !start_router_input.StartRouterInputOutput {
        return start_router_input.execute(self, allocator, input, options);
    }

    /// Starts a router output in AWS Elemental MediaConnect.
    pub fn startRouterOutput(self: *Self, allocator: std.mem.Allocator, input: start_router_output.StartRouterOutputInput, options: CallOptions) !start_router_output.StartRouterOutputOutput {
        return start_router_output.execute(self, allocator, input, options);
    }

    /// Stops a flow.
    pub fn stopFlow(self: *Self, allocator: std.mem.Allocator, input: stop_flow.StopFlowInput, options: CallOptions) !stop_flow.StopFlowOutput {
        return stop_flow.execute(self, allocator, input, options);
    }

    /// Stops a router input in AWS Elemental MediaConnect.
    pub fn stopRouterInput(self: *Self, allocator: std.mem.Allocator, input: stop_router_input.StopRouterInputInput, options: CallOptions) !stop_router_input.StopRouterInputOutput {
        return stop_router_input.execute(self, allocator, input, options);
    }

    /// Stops a router output in AWS Elemental MediaConnect.
    pub fn stopRouterOutput(self: *Self, allocator: std.mem.Allocator, input: stop_router_output.StopRouterOutputInput, options: CallOptions) !stop_router_output.StopRouterOutputOutput {
        return stop_router_output.execute(self, allocator, input, options);
    }

    /// Adds tags to a global resource in AWS Elemental MediaConnect. The API
    /// supports the following global resources: router inputs, router outputs and
    /// router network interfaces.
    pub fn tagGlobalResource(self: *Self, allocator: std.mem.Allocator, input: tag_global_resource.TagGlobalResourceInput, options: CallOptions) !tag_global_resource.TagGlobalResourceOutput {
        return tag_global_resource.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified `resourceArn`
    /// in the current region. If existing tags on a resource are not specified in
    /// the request parameters, they are not changed. When a resource is deleted,
    /// the tags associated with that resource are deleted as well.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Associates a router input with a router output in AWS Elemental
    /// MediaConnect.
    pub fn takeRouterInput(self: *Self, allocator: std.mem.Allocator, input: take_router_input.TakeRouterInputInput, options: CallOptions) !take_router_input.TakeRouterInputOutput {
        return take_router_input.execute(self, allocator, input, options);
    }

    /// Removes tags from a global resource in AWS Elemental MediaConnect. The API
    /// supports the following global resources: router inputs, router outputs and
    /// router network interfaces.
    pub fn untagGlobalResource(self: *Self, allocator: std.mem.Allocator, input: untag_global_resource.UntagGlobalResourceInput, options: CallOptions) !untag_global_resource.UntagGlobalResourceOutput {
        return untag_global_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource in the current region.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the bridge.
    pub fn updateBridge(self: *Self, allocator: std.mem.Allocator, input: update_bridge.UpdateBridgeInput, options: CallOptions) !update_bridge.UpdateBridgeOutput {
        return update_bridge.execute(self, allocator, input, options);
    }

    /// Updates an existing bridge output.
    pub fn updateBridgeOutput(self: *Self, allocator: std.mem.Allocator, input: update_bridge_output.UpdateBridgeOutputInput, options: CallOptions) !update_bridge_output.UpdateBridgeOutputOutput {
        return update_bridge_output.execute(self, allocator, input, options);
    }

    /// Updates an existing bridge source.
    pub fn updateBridgeSource(self: *Self, allocator: std.mem.Allocator, input: update_bridge_source.UpdateBridgeSourceInput, options: CallOptions) !update_bridge_source.UpdateBridgeSourceOutput {
        return update_bridge_source.execute(self, allocator, input, options);
    }

    /// Updates the bridge state.
    pub fn updateBridgeState(self: *Self, allocator: std.mem.Allocator, input: update_bridge_state.UpdateBridgeStateInput, options: CallOptions) !update_bridge_state.UpdateBridgeStateOutput {
        return update_bridge_state.execute(self, allocator, input, options);
    }

    /// Updates an existing flow.
    ///
    /// Because `UpdateFlowSources` and `UpdateFlow` are separate operations, you
    /// can't change both the source type AND the flow size in a single request.
    ///
    /// * If you have a `MEDIUM` flow and you want to change the flow source to
    ///   NDI®:
    ///
    /// * First, use the `UpdateFlow` operation to upgrade the flow size to `LARGE`.
    /// * After that, you can then use the `UpdateFlowSource` operation to configure
    ///   the NDI source.
    ///
    /// * If you're switching from an NDI source to a transport stream (TS) source
    ///   and want to downgrade the flow size:
    ///
    /// * First, use the `UpdateFlowSource` operation to change the flow source
    ///   type.
    /// * After that, you can then use the `UpdateFlow` operation to downgrade the
    ///   flow size to `MEDIUM`.
    pub fn updateFlow(self: *Self, allocator: std.mem.Allocator, input: update_flow.UpdateFlowInput, options: CallOptions) !update_flow.UpdateFlowOutput {
        return update_flow.execute(self, allocator, input, options);
    }

    /// Updates an entitlement. You can change an entitlement's description,
    /// subscribers, and encryption. If you change the subscribers, the service will
    /// remove the outputs that are are used by the subscribers that are removed.
    pub fn updateFlowEntitlement(self: *Self, allocator: std.mem.Allocator, input: update_flow_entitlement.UpdateFlowEntitlementInput, options: CallOptions) !update_flow_entitlement.UpdateFlowEntitlementOutput {
        return update_flow_entitlement.execute(self, allocator, input, options);
    }

    /// Updates an existing media stream.
    pub fn updateFlowMediaStream(self: *Self, allocator: std.mem.Allocator, input: update_flow_media_stream.UpdateFlowMediaStreamInput, options: CallOptions) !update_flow_media_stream.UpdateFlowMediaStreamOutput {
        return update_flow_media_stream.execute(self, allocator, input, options);
    }

    /// Updates an existing flow output.
    pub fn updateFlowOutput(self: *Self, allocator: std.mem.Allocator, input: update_flow_output.UpdateFlowOutputInput, options: CallOptions) !update_flow_output.UpdateFlowOutputOutput {
        return update_flow_output.execute(self, allocator, input, options);
    }

    /// Updates the source of a flow.
    ///
    /// Because `UpdateFlowSources` and `UpdateFlow` are separate operations, you
    /// can't change both the source type AND the flow size in a single request.
    ///
    /// * If you have a `MEDIUM` flow and you want to change the flow source to
    ///   NDI®:
    ///
    /// * First, use the `UpdateFlow` operation to upgrade the flow size to `LARGE`.
    /// * After that, you can then use the `UpdateFlowSource` operation to configure
    ///   the NDI source.
    ///
    /// * If you're switching from an NDI source to a transport stream (TS) source
    ///   and want to downgrade the flow size:
    ///
    /// * First, use the `UpdateFlowSource` operation to change the flow source
    ///   type.
    /// * After that, you can then use the `UpdateFlow` operation to downgrade the
    ///   flow size to `MEDIUM`.
    pub fn updateFlowSource(self: *Self, allocator: std.mem.Allocator, input: update_flow_source.UpdateFlowSourceInput, options: CallOptions) !update_flow_source.UpdateFlowSourceOutput {
        return update_flow_source.execute(self, allocator, input, options);
    }

    /// Updates an existing gateway instance.
    pub fn updateGatewayInstance(self: *Self, allocator: std.mem.Allocator, input: update_gateway_instance.UpdateGatewayInstanceInput, options: CallOptions) !update_gateway_instance.UpdateGatewayInstanceOutput {
        return update_gateway_instance.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing router input in AWS Elemental
    /// MediaConnect.
    pub fn updateRouterInput(self: *Self, allocator: std.mem.Allocator, input: update_router_input.UpdateRouterInputInput, options: CallOptions) !update_router_input.UpdateRouterInputOutput {
        return update_router_input.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing router network interface in AWS
    /// Elemental MediaConnect.
    pub fn updateRouterNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: update_router_network_interface.UpdateRouterNetworkInterfaceInput, options: CallOptions) !update_router_network_interface.UpdateRouterNetworkInterfaceOutput {
        return update_router_network_interface.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing router output in AWS Elemental
    /// MediaConnect.
    pub fn updateRouterOutput(self: *Self, allocator: std.mem.Allocator, input: update_router_output.UpdateRouterOutputInput, options: CallOptions) !update_router_output.UpdateRouterOutputOutput {
        return update_router_output.execute(self, allocator, input, options);
    }

    pub fn listBridgesPaginator(self: *Self, params: list_bridges.ListBridgesInput) paginator.ListBridgesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitlementsPaginator(self: *Self, params: list_entitlements.ListEntitlementsInput) paginator.ListEntitlementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowsPaginator(self: *Self, params: list_flows.ListFlowsInput) paginator.ListFlowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGatewayInstancesPaginator(self: *Self, params: list_gateway_instances.ListGatewayInstancesInput) paginator.ListGatewayInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGatewaysPaginator(self: *Self, params: list_gateways.ListGatewaysInput) paginator.ListGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOfferingsPaginator(self: *Self, params: list_offerings.ListOfferingsInput) paginator.ListOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReservationsPaginator(self: *Self, params: list_reservations.ListReservationsInput) paginator.ListReservationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRouterInputsPaginator(self: *Self, params: list_router_inputs.ListRouterInputsInput) paginator.ListRouterInputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRouterNetworkInterfacesPaginator(self: *Self, params: list_router_network_interfaces.ListRouterNetworkInterfacesInput) paginator.ListRouterNetworkInterfacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRouterOutputsPaginator(self: *Self, params: list_router_outputs.ListRouterOutputsInput) paginator.ListRouterOutputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilFlowActive(self: *Self, params: describe_flow.DescribeFlowInput) aws.waiter.WaiterError!void {
        var w = waiters.FlowActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFlowDeleted(self: *Self, params: describe_flow.DescribeFlowInput) aws.waiter.WaiterError!void {
        var w = waiters.FlowDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFlowStandby(self: *Self, params: describe_flow.DescribeFlowInput) aws.waiter.WaiterError!void {
        var w = waiters.FlowStandbyWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInputActive(self: *Self, params: get_router_input.GetRouterInputInput) aws.waiter.WaiterError!void {
        var w = waiters.InputActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInputDeleted(self: *Self, params: get_router_input.GetRouterInputInput) aws.waiter.WaiterError!void {
        var w = waiters.InputDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInputStandby(self: *Self, params: get_router_input.GetRouterInputInput) aws.waiter.WaiterError!void {
        var w = waiters.InputStandbyWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutputActive(self: *Self, params: get_router_output.GetRouterOutputInput) aws.waiter.WaiterError!void {
        var w = waiters.OutputActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutputDeleted(self: *Self, params: get_router_output.GetRouterOutputInput) aws.waiter.WaiterError!void {
        var w = waiters.OutputDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutputRouted(self: *Self, params: get_router_output.GetRouterOutputInput) aws.waiter.WaiterError!void {
        var w = waiters.OutputRoutedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutputStandby(self: *Self, params: get_router_output.GetRouterOutputInput) aws.waiter.WaiterError!void {
        var w = waiters.OutputStandbyWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilOutputUnrouted(self: *Self, params: get_router_output.GetRouterOutputInput) aws.waiter.WaiterError!void {
        var w = waiters.OutputUnroutedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
