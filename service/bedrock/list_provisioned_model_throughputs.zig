const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortByProvisionedModels = @import("sort_by_provisioned_models.zig").SortByProvisionedModels;
const SortOrder = @import("sort_order.zig").SortOrder;
const ProvisionedModelStatus = @import("provisioned_model_status.zig").ProvisionedModelStatus;
const ProvisionedModelSummary = @import("provisioned_model_summary.zig").ProvisionedModelSummary;

pub const ListProvisionedModelThroughputsInput = struct {
    /// A filter that returns Provisioned Throughputs created after the specified
    /// time.
    creation_time_after: ?i64 = null,

    /// A filter that returns Provisioned Throughputs created before the specified
    /// time.
    creation_time_before: ?i64 = null,

    /// THe maximum number of results to return in the response. If there are more
    /// results than the number you specified, the response returns a `nextToken`
    /// value. To see the next batch of results, send the `nextToken` value in
    /// another list request.
    max_results: ?i32 = null,

    /// A filter that returns Provisioned Throughputs whose model Amazon Resource
    /// Name (ARN) is equal to the value that you specify.
    model_arn_equals: ?[]const u8 = null,

    /// A filter that returns Provisioned Throughputs if their name contains the
    /// expression that you specify.
    name_contains: ?[]const u8 = null,

    /// If there are more results than the number you specified in the `maxResults`
    /// field, the response returns a `nextToken` value. To see the next batch of
    /// results, specify the `nextToken` value in this field.
    next_token: ?[]const u8 = null,

    /// The field by which to sort the returned list of Provisioned Throughputs.
    sort_by: ?SortByProvisionedModels = null,

    /// The sort order of the results.
    sort_order: ?SortOrder = null,

    /// A filter that returns Provisioned Throughputs if their statuses matches the
    /// value that you specify.
    status_equals: ?ProvisionedModelStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "creationTimeAfter",
        .creation_time_before = "creationTimeBefore",
        .max_results = "maxResults",
        .model_arn_equals = "modelArnEquals",
        .name_contains = "nameContains",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .status_equals = "statusEquals",
    };
};

pub const ListProvisionedModelThroughputsOutput = struct {
    /// If there are more results than the number you specified in the `maxResults`
    /// field, this value is returned. To see the next batch of results, include
    /// this value in the `nextToken` field in another list request.
    next_token: ?[]const u8 = null,

    /// A list of summaries, one for each Provisioned Throughput in the response.
    provisioned_model_summaries: ?[]const ProvisionedModelSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .provisioned_model_summaries = "provisionedModelSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProvisionedModelThroughputsInput, options: CallOptions) !ListProvisionedModelThroughputsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProvisionedModelThroughputsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/provisioned-model-throughputs";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.creation_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "creationTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.creation_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "creationTimeBefore=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProvisionedModelThroughputsOutput {
    var result: ListProvisionedModelThroughputsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListProvisionedModelThroughputsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
