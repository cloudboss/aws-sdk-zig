const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubContentType = @import("hub_content_type.zig").HubContentType;

pub const DeleteHubContentReferenceInput = struct {
    /// The name of the hub content to delete.
    hub_content_name: []const u8,

    /// The type of hub content reference to delete. The only supported type of hub
    /// content reference to delete is `ModelReference`.
    hub_content_type: HubContentType,

    /// The name of the hub to delete the hub content reference from.
    hub_name: []const u8,

    pub const json_field_names = .{
        .hub_content_name = "HubContentName",
        .hub_content_type = "HubContentType",
        .hub_name = "HubName",
    };
};

pub const DeleteHubContentReferenceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteHubContentReferenceInput, options: CallOptions) !DeleteHubContentReferenceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteHubContentReferenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DeleteHubContentReference");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteHubContentReferenceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
