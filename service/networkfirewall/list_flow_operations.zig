const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowOperationType = @import("flow_operation_type.zig").FlowOperationType;
const FlowOperationMetadata = @import("flow_operation_metadata.zig").FlowOperationMetadata;

pub const ListFlowOperationsInput = struct {
    /// The ID of the Availability Zone where the firewall is located. For example,
    /// `us-east-2a`.
    ///
    /// Defines the scope a flow operation. You can use up to 20 filters to
    /// configure a single flow operation.
    availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: []const u8,

    /// An optional string that defines whether any or all operation types are
    /// returned.
    flow_operation_type: ?FlowOperationType = null,

    /// The maximum number of objects that you want Network Firewall to return for
    /// this request. If more
    /// objects are available, in the response, Network Firewall provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    max_results: ?i32 = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Network Firewall returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: ?[]const u8 = null,

    /// A unique identifier for the primary endpoint associated with a firewall.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .firewall_arn = "FirewallArn",
        .flow_operation_type = "FlowOperationType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub const ListFlowOperationsOutput = struct {
    /// Flow operations let you manage the flows tracked in the flow table, also
    /// known as the firewall table.
    ///
    /// A flow is network traffic that is monitored by a firewall, either by
    /// stateful or stateless rules.
    /// For traffic to be considered part of a flow, it must share Destination,
    /// DestinationPort, Direction, Protocol, Source, and SourcePort.
    flow_operations: ?[]const FlowOperationMetadata = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Network Firewall returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_operations = "FlowOperations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFlowOperationsInput, options: CallOptions) !ListFlowOperationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListFlowOperationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.ListFlowOperations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFlowOperationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFlowOperationsOutput, body, allocator);
}
