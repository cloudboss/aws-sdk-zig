const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListHapgsInput = struct {
    /// The `NextToken` value from a previous call to `ListHapgs`. Pass
    /// null if this is the first call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
    };
};

pub const ListHapgsOutput = struct {
    /// The list of high-availability partition groups.
    hapg_list: ?[]const []const u8 = null,

    /// If not null, more results are available. Pass this value to `ListHapgs` to
    /// retrieve the next set of items.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .hapg_list = "HapgList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHapgsInput, options: CallOptions) !ListHapgsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHapgsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.ListHapgs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHapgsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListHapgsOutput, body, allocator);
}
