const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataViewDestinationTypeParams = @import("data_view_destination_type_params.zig").DataViewDestinationTypeParams;

pub const CreateDataViewInput = struct {
    /// Beginning time to use for the Dataview. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    as_of_timestamp: ?i64 = null,

    /// Flag to indicate Dataview should be updated automatically.
    auto_update: ?bool = null,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// The unique Dataset identifier that is used to create a Dataview.
    dataset_id: []const u8,

    /// Options that define the destination type for the Dataview.
    destination_type_params: DataViewDestinationTypeParams,

    /// Ordered set of column names used to partition data.
    partition_columns: ?[]const []const u8 = null,

    /// Columns to be used for sorting the data.
    sort_columns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .as_of_timestamp = "asOfTimestamp",
        .auto_update = "autoUpdate",
        .client_token = "clientToken",
        .dataset_id = "datasetId",
        .destination_type_params = "destinationTypeParams",
        .partition_columns = "partitionColumns",
        .sort_columns = "sortColumns",
    };
};

pub const CreateDataViewOutput = struct {
    /// The unique identifier of the Dataset used for the Dataview.
    dataset_id: ?[]const u8 = null,

    /// The unique identifier for the created Dataview.
    data_view_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .data_view_id = "dataViewId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataViewInput, options: CallOptions) !CreateDataViewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/dataviewsv2");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.as_of_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"asOfTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationTypeParams\":");
    try aws.json.writeValue(@TypeOf(input.destination_type_params), input.destination_type_params, allocator, &body_buf);
    has_prev = true;
    if (input.partition_columns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"partitionColumns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_columns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortColumns\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataViewOutput {
    var result: CreateDataViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
