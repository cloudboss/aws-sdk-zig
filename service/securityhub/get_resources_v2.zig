const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcesFilters = @import("resources_filters.zig").ResourcesFilters;
const ResourceScopes = @import("resource_scopes.zig").ResourceScopes;
const SortCriterion = @import("sort_criterion.zig").SortCriterion;
const ResourceResult = @import("resource_result.zig").ResourceResult;

pub const GetResourcesV2Input = struct {
    /// Filters resources based on a set of criteria.
    filters: ?ResourcesFilters = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The token required for pagination.
    /// On your first call, set the value of this parameter to `NULL`.
    /// For subsequent calls, to continue listing data, set the value of this
    /// parameter to the value returned in the previous response.
    next_token: ?[]const u8 = null,

    /// Limits the results to resources from specific organizational units or from
    /// the delegated administrator's organization.
    /// Only the delegated administrator account can use this parameter. Other
    /// accounts receive an `AccessDeniedException`.
    ///
    /// This parameter is optional. If you omit it, the delegated administrator sees
    /// resources from all accounts across the entire organization. Other accounts
    /// see only their own resources.
    ///
    /// You can specify up to 10 entries in `Scopes.AwsOrganizations`. If multiple
    /// entries are specified, the entries are combined using OR logic.
    scopes: ?ResourceScopes = null,

    /// The resource attributes used to sort the list of returned resources.
    sort_criteria: ?[]const SortCriterion = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .scopes = "Scopes",
        .sort_criteria = "SortCriteria",
    };
};

pub const GetResourcesV2Output = struct {
    /// The pagination token to use to request the next page of results.
    /// Otherwise, this parameter is null.
    next_token: ?[]const u8 = null,

    /// An array of resources returned by the operation.
    resources: ?[]const ResourceResult = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resources = "Resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcesV2Input, options: CallOptions) !GetResourcesV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourcesV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resourcesv2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Scopes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourcesV2Output {
    const result: GetResourcesV2Output = try aws.json.parseJsonObject(
        GetResourcesV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
