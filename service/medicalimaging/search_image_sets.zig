const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchCriteria = @import("search_criteria.zig").SearchCriteria;
const ImageSetsMetadataSummary = @import("image_sets_metadata_summary.zig").ImageSetsMetadataSummary;
const Sort = @import("sort.zig").Sort;

pub const SearchImageSetsInput = struct {
    /// The identifier of the data store where the image sets reside.
    datastore_id: []const u8,

    /// The maximum number of results that can be returned in a search.
    max_results: ?i32 = null,

    /// The token used for pagination of results returned in the response. Use the
    /// token returned from the previous request to continue results where the
    /// previous request ended.
    next_token: ?[]const u8 = null,

    /// The search criteria that filters by applying a maximum of 1 item to
    /// `SearchByAttribute`.
    search_criteria: ?SearchCriteria = null,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .search_criteria = "searchCriteria",
    };
};

pub const SearchImageSetsOutput = struct {
    /// The model containing the image set results.
    image_sets_metadata_summaries: ?[]const ImageSetsMetadataSummary = null,

    /// The token for pagination results.
    next_token: ?[]const u8 = null,

    /// The sort order for image set search results.
    sort: ?Sort = null,

    pub const json_field_names = .{
        .image_sets_metadata_summaries = "imageSetsMetadataSummaries",
        .next_token = "nextToken",
        .sort = "sort",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchImageSetsInput, options: CallOptions) !SearchImageSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medical-imaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchImageSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datastore/");
    try path_buf.appendSlice(allocator, input.datastore_id);
    try path_buf.appendSlice(allocator, "/searchImageSets");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = if (input.search_criteria) |v| try aws.json.jsonStringify(v, allocator) else null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchImageSetsOutput {
    var result: SearchImageSetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchImageSetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
