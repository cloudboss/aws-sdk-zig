const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheReportInfo = @import("cache_report_info.zig").CacheReportInfo;

pub const ListCacheReportsInput = struct {
    /// Opaque pagination token returned from a previous `ListCacheReports`
    /// operation. If present, `Marker` specifies where to continue the list from
    /// after
    /// a previous call to `ListCacheReports`. Optional.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .marker = "Marker",
    };
};

pub const ListCacheReportsOutput = struct {
    /// A list of existing cache reports for all file shares associated with your
    /// Amazon Web Services account. This list includes all information provided by
    /// the
    /// `DescribeCacheReport` action, such as report status, completion progress,
    /// start time, end time, filters, and tags.
    cache_report_list: ?[]const CacheReportInfo = null,

    /// If the request includes `Marker`, the response returns that value in this
    /// field.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_report_list = "CacheReportList",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCacheReportsInput, options: CallOptions) !ListCacheReportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCacheReportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.ListCacheReports");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCacheReportsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCacheReportsOutput, body, allocator);
}
