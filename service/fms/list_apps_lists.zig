const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppsListDataSummary = @import("apps_list_data_summary.zig").AppsListDataSummary;

pub const ListAppsListsInput = struct {
    /// Specifies whether the lists to retrieve are default lists owned by Firewall
    /// Manager.
    default_lists: ?bool = null,

    /// The maximum number of objects that you want Firewall Manager to return for
    /// this request. If more
    /// objects are available, in the response, Firewall Manager provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    ///
    /// If you don't specify this, Firewall Manager returns all available objects.
    max_results: i32,

    /// If you specify a value for `MaxResults` in your list request, and you have
    /// more objects than the maximum,
    /// Firewall Manager returns this token in the response. For all but the first
    /// request, you provide the token returned by the prior request
    /// in the request parameters, to retrieve the next batch of objects.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_lists = "DefaultLists",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAppsListsOutput = struct {
    /// An array of `AppsListDataSummary` objects.
    apps_lists: ?[]const AppsListDataSummary = null,

    /// If you specify a value for `MaxResults` in your list request, and you have
    /// more objects than the maximum,
    /// Firewall Manager returns this token in the response. You can use this token
    /// in subsequent requests to retrieve the next batch of objects.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .apps_lists = "AppsLists",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppsListsInput, options: CallOptions) !ListAppsListsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppsListsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.ListAppsLists");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppsListsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAppsListsOutput, body, allocator);
}
