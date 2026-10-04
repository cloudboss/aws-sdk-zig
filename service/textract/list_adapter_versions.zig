const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdapterVersionOverview = @import("adapter_version_overview.zig").AdapterVersionOverview;

pub const ListAdapterVersionsInput = struct {
    /// A string containing a unique ID for the adapter to match for when listing
    /// adapter versions.
    adapter_id: ?[]const u8 = null,

    /// Specifies the lower bound for the ListAdapterVersions operation.
    /// Ensures ListAdapterVersions returns only adapter versions created after the
    /// specified creation time.
    after_creation_time: ?i64 = null,

    /// Specifies the upper bound for the ListAdapterVersions operation.
    /// Ensures ListAdapterVersions returns only adapter versions created after the
    /// specified creation time.
    before_creation_time: ?i64 = null,

    /// The maximum number of results to return when listing adapter versions.
    max_results: ?i32 = null,

    /// Identifies the next page of results to return when listing adapter versions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .after_creation_time = "AfterCreationTime",
        .before_creation_time = "BeforeCreationTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAdapterVersionsOutput = struct {
    /// Adapter versions that match the filtering criteria specified when calling
    /// ListAdapters.
    adapter_versions: ?[]const AdapterVersionOverview = null,

    /// Identifies the next page of results to return when listing adapter versions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .adapter_versions = "AdapterVersions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAdapterVersionsInput, options: CallOptions) !ListAdapterVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAdapterVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.ListAdapterVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAdapterVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAdapterVersionsOutput, body, allocator);
}
