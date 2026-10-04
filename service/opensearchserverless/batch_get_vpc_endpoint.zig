const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcEndpointDetail = @import("vpc_endpoint_detail.zig").VpcEndpointDetail;
const VpcEndpointErrorDetail = @import("vpc_endpoint_error_detail.zig").VpcEndpointErrorDetail;

pub const BatchGetVpcEndpointInput = struct {
    /// A list of VPC endpoint identifiers.
    ids: []const []const u8,

    pub const json_field_names = .{
        .ids = "ids",
    };
};

pub const BatchGetVpcEndpointOutput = struct {
    /// Details about the specified VPC endpoint.
    vpc_endpoint_details: ?[]const VpcEndpointDetail = null,

    /// Error information for a failed request.
    vpc_endpoint_error_details: ?[]const VpcEndpointErrorDetail = null,

    pub const json_field_names = .{
        .vpc_endpoint_details = "vpcEndpointDetails",
        .vpc_endpoint_error_details = "vpcEndpointErrorDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetVpcEndpointInput, options: CallOptions) !BatchGetVpcEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetVpcEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.BatchGetVpcEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetVpcEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetVpcEndpointOutput, body, allocator);
}
