const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateVpcEndpointDetail = @import("create_vpc_endpoint_detail.zig").CreateVpcEndpointDetail;

pub const CreateVpcEndpointInput = struct {
    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The name of the interface endpoint.
    name: []const u8,

    /// The unique identifiers of the security groups that define the ports,
    /// protocols, and sources for inbound traffic that you are authorizing into
    /// your endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID of one or more subnets from which you'll access OpenSearch
    /// Serverless.
    subnet_ids: []const []const u8,

    /// The ID of the VPC from which you'll access OpenSearch Serverless.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .name = "name",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};

pub const CreateVpcEndpointOutput = struct {
    /// Details about the created interface VPC endpoint.
    create_vpc_endpoint_detail: ?CreateVpcEndpointDetail = null,

    pub const json_field_names = .{
        .create_vpc_endpoint_detail = "createVpcEndpointDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpcEndpointInput, options: CallOptions) !CreateVpcEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpcEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.CreateVpcEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpcEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVpcEndpointOutput, body, allocator);
}
