const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReleaseLabelFilter = @import("release_label_filter.zig").ReleaseLabelFilter;

pub const ListReleaseLabelsInput = struct {
    /// Filters the results of the request. `Prefix` specifies the prefix of release
    /// labels to return. `Application` specifies the application (with/without
    /// version)
    /// of release labels to return.
    filters: ?ReleaseLabelFilter = null,

    /// Defines the maximum number of release labels to return in a single response.
    /// The default
    /// is `100`.
    max_results: ?i32 = null,

    /// Specifies the next page of results. If `NextToken` is not specified, which
    /// is
    /// usually the case for the first request of ListReleaseLabels, the first page
    /// of results are
    /// determined by other filtering parameters or by the latest version. The
    /// `ListReleaseLabels` request fails if the identity (Amazon Web Services
    /// account
    /// ID) and all filtering parameters are different from the original request, or
    /// if the
    /// `NextToken` is expired or tampered with.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListReleaseLabelsOutput = struct {
    /// Used to paginate the next page of results if specified in the next
    /// `ListReleaseLabels` request.
    next_token: ?[]const u8 = null,

    /// The returned release labels.
    release_labels: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .release_labels = "ReleaseLabels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReleaseLabelsInput, options: CallOptions) !ListReleaseLabelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReleaseLabelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.ListReleaseLabels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReleaseLabelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListReleaseLabelsOutput, body, allocator);
}
