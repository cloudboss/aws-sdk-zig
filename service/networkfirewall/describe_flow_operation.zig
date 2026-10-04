const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowOperation = @import("flow_operation.zig").FlowOperation;
const FlowOperationStatus = @import("flow_operation_status.zig").FlowOperationStatus;
const FlowOperationType = @import("flow_operation_type.zig").FlowOperationType;

pub const DescribeFlowOperationInput = struct {
    /// The ID of the Availability Zone where the firewall is located. For example,
    /// `us-east-2a`.
    ///
    /// Defines the scope a flow operation. You can use up to 20 filters to
    /// configure a single flow operation.
    availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: []const u8,

    /// A unique identifier for the flow operation. This ID is returned in the
    /// responses to start and list commands. You provide to describe commands.
    flow_operation_id: []const u8,

    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: ?[]const u8 = null,

    /// A unique identifier for the primary endpoint associated with a firewall.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .firewall_arn = "FirewallArn",
        .flow_operation_id = "FlowOperationId",
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub const DescribeFlowOperationOutput = struct {
    /// The ID of the Availability Zone where the firewall is located. For example,
    /// `us-east-2a`.
    ///
    /// Defines the scope a flow operation. You can use up to 20 filters to
    /// configure a single flow operation.
    availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// Returns key information about a flow operation, such as related statuses,
    /// unique identifiers, and all filters defined in the operation.
    flow_operation: ?FlowOperation = null,

    /// A unique identifier for the flow operation. This ID is returned in the
    /// responses to start and list commands. You provide to describe commands.
    flow_operation_id: ?[]const u8 = null,

    /// Returns the status of the flow operation. This string is returned in the
    /// responses to start, list, and describe commands.
    ///
    /// If the status is `COMPLETED_WITH_ERRORS`, results may be returned with any
    /// number of `Flows` missing from the response.
    /// If the status is `FAILED`, `Flows` returned will be empty.
    flow_operation_status: ?FlowOperationStatus = null,

    /// Defines the type of `FlowOperation`.
    flow_operation_type: ?FlowOperationType = null,

    /// A timestamp indicating when the Suricata engine identified flows impacted by
    /// an operation.
    flow_request_timestamp: ?i64 = null,

    /// If the asynchronous operation fails, Network Firewall populates this with
    /// the reason for the error or failure. Options include `Flow operation error`
    /// and `Flow timeout`.
    status_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: ?[]const u8 = null,

    /// A unique identifier for the primary endpoint associated with a firewall.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .firewall_arn = "FirewallArn",
        .flow_operation = "FlowOperation",
        .flow_operation_id = "FlowOperationId",
        .flow_operation_status = "FlowOperationStatus",
        .flow_operation_type = "FlowOperationType",
        .flow_request_timestamp = "FlowRequestTimestamp",
        .status_message = "StatusMessage",
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFlowOperationInput, options: CallOptions) !DescribeFlowOperationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFlowOperationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeFlowOperation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFlowOperationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFlowOperationOutput, body, allocator);
}
