const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexStatus = @import("index_status.zig").IndexStatus;

pub const DescribeIndexInput = struct {
    /// The index name.
    index_name: []const u8,

    pub const json_field_names = .{
        .index_name = "indexName",
    };
};

pub const DescribeIndexOutput = struct {
    /// The index name.
    index_name: ?[]const u8 = null,

    /// The index status.
    index_status: ?IndexStatus = null,

    /// Contains a value that specifies the type of indexing performed. Valid values
    /// are:
    ///
    /// * REGISTRY – Your thing index contains only registry data.
    ///
    /// * REGISTRY_AND_SHADOW - Your thing index contains registry data and shadow
    ///   data.
    ///
    /// * REGISTRY_AND_CONNECTIVITY_STATUS - Your thing index contains registry data
    ///   and
    /// thing connectivity status data.
    ///
    /// * REGISTRY_AND_SHADOW_AND_CONNECTIVITY_STATUS - Your thing index contains
    ///   registry
    /// data, shadow data, and thing connectivity status data.
    ///
    /// * MULTI_INDEXING_MODE - Your thing index contains multiple data sources. For
    ///   more information, see
    /// [GetIndexingConfiguration](https://docs.aws.amazon.com/iot/latest/apireference/API_GetIndexingConfiguration.html).
    schema: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_name = "indexName",
        .index_status = "indexStatus",
        .schema = "schema",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIndexInput, options: CallOptions) !DescribeIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIndexOutput {
    const result: DescribeIndexOutput = try aws.json.parseJsonObject(
        DescribeIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
