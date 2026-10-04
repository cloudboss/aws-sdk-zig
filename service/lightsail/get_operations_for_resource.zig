const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Operation = @import("operation.zig").Operation;

pub const GetOperationsForResourceInput = struct {
    /// The token to advance to the next page of results from your request.
    ///
    /// To get a page token, perform an initial `GetOperationsForResource` request.
    /// If
    /// your results are paginated, the response will return a next page token that
    /// you can specify as
    /// the page token in a subsequent request.
    page_token: ?[]const u8 = null,

    /// The name of the resource for which you are requesting information.
    resource_name: []const u8,

    pub const json_field_names = .{
        .page_token = "pageToken",
        .resource_name = "resourceName",
    };
};

pub const GetOperationsForResourceOutput = struct {
    /// (Discontinued) Returns the number of pages of results that remain.
    ///
    /// In releases prior to June 12, 2017, this parameter returned `null` by the
    /// API. It is now discontinued, and the API returns the `next page token`
    /// parameter
    /// instead.
    next_page_count: ?[]const u8 = null,

    /// The token to advance to the next page of results from your request.
    ///
    /// A next page token is not returned if there are no more results to display.
    ///
    /// To get the next page of results, perform another `GetOperationsForResource`
    /// request and specify the next page token using the `pageToken` parameter.
    next_page_token: ?[]const u8 = null,

    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .next_page_count = "nextPageCount",
        .next_page_token = "nextPageToken",
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOperationsForResourceInput, options: CallOptions) !GetOperationsForResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOperationsForResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetOperationsForResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOperationsForResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOperationsForResourceOutput, body, allocator);
}
