const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceAssociationSearchCriteria = @import("workspace_association_search_criteria.zig").WorkspaceAssociationSearchCriteria;
const WorkspaceAssociationSearchFilter = @import("workspace_association_search_filter.zig").WorkspaceAssociationSearchFilter;
const WorkspaceAssociationSearchSummary = @import("workspace_association_search_summary.zig").WorkspaceAssociationSearchSummary;

pub const SearchWorkspaceAssociationsInput = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in
    /// the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to
    /// retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The search criteria, including workspace ID, resource ID, or resource type.
    search_criteria: ?WorkspaceAssociationSearchCriteria = null,

    /// Filters to apply to the search, such as tag-based filters.
    search_filter: ?WorkspaceAssociationSearchFilter = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .search_criteria = "SearchCriteria",
        .search_filter = "SearchFilter",
    };
};

pub const SearchWorkspaceAssociationsOutput = struct {
    /// The approximate total number of workspace associations that match the search
    /// criteria.
    approximate_total_count: ?i64 = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of workspace associations that match the search criteria.
    workspace_associations: ?[]const WorkspaceAssociationSearchSummary = null,

    pub const json_field_names = .{
        .approximate_total_count = "ApproximateTotalCount",
        .next_token = "NextToken",
        .workspace_associations = "WorkspaceAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchWorkspaceAssociationsInput, options: CallOptions) !SearchWorkspaceAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchWorkspaceAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/search-workspace-associations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
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
    if (input.search_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SearchCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.search_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SearchFilter\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchWorkspaceAssociationsOutput {
    const result: SearchWorkspaceAssociationsOutput = try aws.json.parseJsonObject(
        SearchWorkspaceAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
