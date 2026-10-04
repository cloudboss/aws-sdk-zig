const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Resource = @import("resource.zig").Resource;
const LFTagPair = @import("lf_tag_pair.zig").LFTagPair;
const ColumnLFTag = @import("column_lf_tag.zig").ColumnLFTag;

pub const GetResourceLFTagsInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    /// The database, table, or column resource for which you want to return
    /// LF-tags.
    resource: Resource,

    /// Indicates whether to show the assigned LF-tags.
    show_assigned_lf_tags: ?bool = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .resource = "Resource",
        .show_assigned_lf_tags = "ShowAssignedLFTags",
    };
};

pub const GetResourceLFTagsOutput = struct {
    /// A list of LF-tags applied to a database resource.
    lf_tag_on_database: ?[]const LFTagPair = null,

    /// A list of LF-tags applied to a column resource.
    lf_tags_on_columns: ?[]const ColumnLFTag = null,

    /// A list of LF-tags applied to a table resource.
    lf_tags_on_table: ?[]const LFTagPair = null,

    pub const json_field_names = .{
        .lf_tag_on_database = "LFTagOnDatabase",
        .lf_tags_on_columns = "LFTagsOnColumns",
        .lf_tags_on_table = "LFTagsOnTable",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceLFTagsInput, options: CallOptions) !GetResourceLFTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceLFTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetResourceLFTags";

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
    try body_buf.appendSlice(allocator, "\"Resource\":");
    try aws.json.writeValue(@TypeOf(input.resource), input.resource, allocator, &body_buf);
    has_prev = true;
    if (input.show_assigned_lf_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ShowAssignedLFTags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceLFTagsOutput {
    const result: GetResourceLFTagsOutput = try aws.json.parseJsonObject(
        GetResourceLFTagsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
