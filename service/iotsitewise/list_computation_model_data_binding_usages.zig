const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataBindingValueFilter = @import("data_binding_value_filter.zig").DataBindingValueFilter;
const ComputationModelDataBindingUsageSummary = @import("computation_model_data_binding_usage_summary.zig").ComputationModelDataBindingUsageSummary;

pub const ListComputationModelDataBindingUsagesInput = struct {
    /// A filter used to limit the returned data binding usages based on specific
    /// data binding
    /// values. You can filter by asset, asset model, asset property, or asset model
    /// property to find
    /// all computation models using these specific data sources.
    data_binding_value_filter: DataBindingValueFilter,

    /// The maximum number of results returned for each paginated request.
    max_results: ?i32 = null,

    /// The token used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_binding_value_filter = "dataBindingValueFilter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListComputationModelDataBindingUsagesOutput = struct {
    /// A list of summaries describing the data binding usages across computation
    /// models. Each
    /// summary includes the computation model IDs and the matched data binding
    /// details.
    data_binding_usage_summaries: ?[]const ComputationModelDataBindingUsageSummary = null,

    /// The token for the next set of paginated results, or null if there are no
    /// additional
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_binding_usage_summaries = "dataBindingUsageSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListComputationModelDataBindingUsagesInput, options: CallOptions) !ListComputationModelDataBindingUsagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListComputationModelDataBindingUsagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/computation-models/data-binding-usages";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataBindingValueFilter\":");
    try aws.json.writeValue(@TypeOf(input.data_binding_value_filter), input.data_binding_value_filter, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListComputationModelDataBindingUsagesOutput {
    const result: ListComputationModelDataBindingUsagesOutput = try aws.json.parseJsonObject(
        ListComputationModelDataBindingUsagesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
