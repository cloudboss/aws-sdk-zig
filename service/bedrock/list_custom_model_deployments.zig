const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortModelsBy = @import("sort_models_by.zig").SortModelsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const CustomModelDeploymentStatus = @import("custom_model_deployment_status.zig").CustomModelDeploymentStatus;
const CustomModelDeploymentSummary = @import("custom_model_deployment_summary.zig").CustomModelDeploymentSummary;

pub const ListCustomModelDeploymentsInput = struct {
    /// Filters deployments created after the specified date and time.
    created_after: ?i64 = null,

    /// Filters deployments created before the specified date and time.
    created_before: ?i64 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// Filters deployments by the Amazon Resource Name (ARN) of the associated
    /// custom model.
    model_arn_equals: ?[]const u8 = null,

    /// Filters deployments whose names contain the specified string.
    name_contains: ?[]const u8 = null,

    /// The token for the next set of results. Use this token to retrieve additional
    /// results when the response is truncated.
    next_token: ?[]const u8 = null,

    /// The field to sort the results by. The only supported value is
    /// `CreationTime`.
    sort_by: ?SortModelsBy = null,

    /// The sort order for the results. Valid values are `Ascending` and
    /// `Descending`. Default is `Descending`.
    sort_order: ?SortOrder = null,

    /// Filters deployments by status. Valid values are `CREATING`, `ACTIVE`, and
    /// `FAILED`.
    status_equals: ?CustomModelDeploymentStatus = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .max_results = "maxResults",
        .model_arn_equals = "modelArnEquals",
        .name_contains = "nameContains",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .status_equals = "statusEquals",
    };
};

pub const ListCustomModelDeploymentsOutput = struct {
    /// A list of custom model deployment summaries.
    model_deployment_summaries: ?[]const CustomModelDeploymentSummary = null,

    /// The token for the next set of results. This value is null when there are no
    /// more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_deployment_summaries = "modelDeploymentSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCustomModelDeploymentsInput, options: CallOptions) !ListCustomModelDeploymentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCustomModelDeploymentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/model-customization/custom-model-deployments";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.created_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "createdAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.created_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "createdBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.model_arn_equals) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "modelArnEquals=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.name_contains) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nameContains=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status_equals) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "statusEquals=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCustomModelDeploymentsOutput {
    const result: ListCustomModelDeploymentsOutput = try aws.json.parseJsonObject(
        ListCustomModelDeploymentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
