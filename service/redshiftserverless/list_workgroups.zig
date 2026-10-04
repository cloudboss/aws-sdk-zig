const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Workgroup = @import("workgroup.zig").Workgroup;

pub const ListWorkgroupsInput = struct {
    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use `nextToken` to display the next page of results.
    max_results: ?i32 = null,

    /// If your initial ListWorkgroups operation returns a `nextToken`, you can
    /// include the returned `nextToken` in following ListNamespaces operations,
    /// which returns results in the next page.
    next_token: ?[]const u8 = null,

    /// The owner Amazon Web Services account for the Amazon Redshift Serverless
    /// workgroup.
    owner_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .owner_account = "ownerAccount",
    };
};

pub const ListWorkgroupsOutput = struct {
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. To retrieve the next
    /// page, make the call again using the returned token.
    next_token: ?[]const u8 = null,

    /// The returned array of workgroups.
    workgroups: ?[]const Workgroup = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .workgroups = "workgroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkgroupsInput, options: CallOptions) !ListWorkgroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkgroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.ListWorkgroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkgroupsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListWorkgroupsOutput, body, allocator);
}
