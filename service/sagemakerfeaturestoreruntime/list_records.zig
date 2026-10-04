const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListRecordsInput = struct {
    /// The name or Amazon Resource Name (ARN) of the feature group to list records
    /// from.
    feature_group_name: []const u8,

    /// If set to `true`, the result includes records that have been soft
    /// deleted.
    include_soft_deleted_records: ?bool = null,

    /// The maximum number of record identifiers to return in a single page of
    /// results. For the `InMemory` tier, this value is a hint and not a strict
    /// requirement. The response may contain more or fewer results than the
    /// specified `MaxResults`.
    max_results: ?i32 = null,

    /// A token to resume pagination of `ListRecords` results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .include_soft_deleted_records = "IncludeSoftDeletedRecords",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListRecordsOutput = struct {
    /// A token to resume pagination if the response includes more record
    /// identifiers than
    /// `MaxResults`.
    next_token: ?[]const u8 = null,

    /// A list of record identifier values for the records stored in the
    /// `OnlineStore`.
    record_identifiers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .record_identifiers = "RecordIdentifiers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecordsInput, options: CallOptions) !ListRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("featurestore-runtime.sagemaker", "SageMaker FeatureStore Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/FeatureGroup/");
    try path_buf.appendSlice(allocator, input.feature_group_name);
    try path_buf.appendSlice(allocator, "/ListRecords");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.include_soft_deleted_records) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeSoftDeletedRecords\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecordsOutput {
    const result: ListRecordsOutput = try aws.json.parseJsonObject(
        ListRecordsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
