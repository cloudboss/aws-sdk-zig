const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdditionalResponseFieldType = @import("additional_response_field_type.zig").AdditionalResponseFieldType;
const Filters = @import("filters.zig").Filters;
const SearchSortResult = @import("search_sort_result.zig").SearchSortResult;
const SearchQueryScopeType = @import("search_query_scope_type.zig").SearchQueryScopeType;
const ResponseItem = @import("response_item.zig").ResponseItem;

pub const SearchResourcesInput = struct {
    /// A list of attributes to include in the response. Used to request fields that
    /// are not normally
    /// returned in a standard response.
    additional_response_fields: ?[]const AdditionalResponseFieldType = null,

    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// Filters results based on entity metadata.
    filters: ?Filters = null,

    /// Max results count per page.
    limit: ?i32 = null,

    /// The marker for the next set of results.
    marker: ?[]const u8 = null,

    /// Order by results in one or more categories.
    order_by: ?[]const SearchSortResult = null,

    /// Filters based on the resource owner OrgId. This is a mandatory parameter
    /// when using Admin SigV4 credentials.
    organization_id: ?[]const u8 = null,

    /// Filter based on the text field type. A Folder has only a name and no
    /// content. A Comment has only content and no name. A Document or Document
    /// Version has a name and content
    query_scopes: ?[]const SearchQueryScopeType = null,

    /// The String to search for. Searches across different text fields based on
    /// request parameters. Use double quotes around the query string for exact
    /// phrase matches.
    query_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_response_fields = "AdditionalResponseFields",
        .authentication_token = "AuthenticationToken",
        .filters = "Filters",
        .limit = "Limit",
        .marker = "Marker",
        .order_by = "OrderBy",
        .organization_id = "OrganizationId",
        .query_scopes = "QueryScopes",
        .query_text = "QueryText",
    };
};

pub const SearchResourcesOutput = struct {
    /// List of Documents, Folders, Comments, and Document Versions matching the
    /// query.
    items: ?[]const ResponseItem = null,

    /// The marker to use when requesting the next set of results. If there are no
    /// additional results, the string is empty.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchResourcesInput, options: CallOptions) !SearchResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/v1/search";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_response_fields) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalResponseFields\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Limit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.marker) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Marker\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.order_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrderBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.organization_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryScopes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryText\":");
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
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchResourcesOutput {
    var result: SearchResourcesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchResourcesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
