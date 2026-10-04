const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Container = @import("container.zig").Container;

pub const ListContainersInput = struct {
    /// Enter the maximum number of containers in the response. Use from 1 to 255
    /// characters.
    max_results: ?i32 = null,

    /// Only if you used `MaxResults` in the first command, enter the token (which
    /// was included in the previous response) to obtain the next set of containers.
    /// This token is
    /// included in a response only if there actually are more containers to list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListContainersOutput = struct {
    /// The names of the containers.
    containers: ?[]const Container = null,

    /// `NextToken` is the token to use in the next call to `ListContainers`.
    /// This token is returned only if you included the `MaxResults` tag in the
    /// original
    /// command, and only if there are still containers to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .containers = "Containers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListContainersInput, options: CallOptions) !ListContainersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediastore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListContainersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediastore", "MediaStore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MediaStore_20170901.ListContainers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListContainersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListContainersOutput, body, allocator);
}
