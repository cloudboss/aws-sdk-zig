const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessLevelFilter = @import("access_level_filter.zig").AccessLevelFilter;
const ListRecordHistorySearchFilter = @import("list_record_history_search_filter.zig").ListRecordHistorySearchFilter;
const RecordDetail = @import("record_detail.zig").RecordDetail;

pub const ListRecordHistoryInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The access level to use to obtain results. The default is `User`.
    access_level_filter: ?AccessLevelFilter = null,

    /// The maximum number of items to return with this call.
    page_size: ?i32 = null,

    /// The page token for the next set of results. To retrieve the first set of
    /// results, use null.
    page_token: ?[]const u8 = null,

    /// The search filter to scope the results.
    search_filter: ?ListRecordHistorySearchFilter = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .access_level_filter = "AccessLevelFilter",
        .page_size = "PageSize",
        .page_token = "PageToken",
        .search_filter = "SearchFilter",
    };
};

pub const ListRecordHistoryOutput = struct {
    /// The page token to use to retrieve the next set of results. If there are no
    /// additional results, this value is null.
    next_page_token: ?[]const u8 = null,

    /// The records, in reverse chronological order.
    record_details: ?[]const RecordDetail = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .record_details = "RecordDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecordHistoryInput, options: CallOptions) !ListRecordHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecordHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.ListRecordHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecordHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRecordHistoryOutput, body, allocator);
}
