const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LFTag = @import("lf_tag.zig").LFTag;
const TaggedDatabase = @import("tagged_database.zig").TaggedDatabase;

pub const SearchDatabasesByLFTagsInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    /// A list of conditions (`LFTag` structures) to search for in database
    /// resources.
    expression: []const LFTag,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A continuation token, if this is not the first call to retrieve this list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .expression = "Expression",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const SearchDatabasesByLFTagsOutput = struct {
    /// A list of databases that meet the LF-tag conditions.
    database_list: ?[]const TaggedDatabase = null,

    /// A continuation token, present if the current list segment is not the last.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_list = "DatabaseList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchDatabasesByLFTagsInput, options: CallOptions) !SearchDatabasesByLFTagsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchDatabasesByLFTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/SearchDatabasesByLFTags";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Expression\":");
    try aws.json.writeValue(@TypeOf(input.expression), input.expression, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchDatabasesByLFTagsOutput {
    var result: SearchDatabasesByLFTagsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchDatabasesByLFTagsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
