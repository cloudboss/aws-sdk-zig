const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceIntrospectionResult = @import("data_source_introspection_result.zig").DataSourceIntrospectionResult;
const DataSourceIntrospectionStatus = @import("data_source_introspection_status.zig").DataSourceIntrospectionStatus;

pub const GetDataSourceIntrospectionInput = struct {
    /// A boolean flag that determines whether SDL should be generated for
    /// introspected types.
    /// If set to `true`, each model will contain an `sdl` property that
    /// contains the SDL for that type. The SDL only contains the type data and no
    /// additional
    /// metadata or directives.
    include_models_sdl: ?bool = null,

    /// The introspection ID. Each introspection contains a unique ID that can be
    /// used to
    /// reference the instrospection record.
    introspection_id: []const u8,

    /// The maximum number of introspected types that will be returned in a single
    /// response.
    max_results: ?i32 = null,

    /// Determines the number of types to be returned in a single response before
    /// paginating.
    /// This value is typically taken from `nextToken` value from the previous
    /// response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_models_sdl = "includeModelsSDL",
        .introspection_id = "introspectionId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetDataSourceIntrospectionOutput = struct {
    /// The introspection ID. Each introspection contains a unique ID that can be
    /// used to
    /// reference the instrospection record.
    introspection_id: ?[]const u8 = null,

    /// The `DataSourceIntrospectionResult` object data.
    introspection_result: ?DataSourceIntrospectionResult = null,

    /// The status of the introspection during retrieval. By default, when a new
    /// instrospection
    /// is being retrieved, the status will be set to `PROCESSING`. Once the
    /// operation
    /// has been completed, the status will change to `SUCCESS` or `FAILED`
    /// depending on how the data was parsed. A `FAILED` operation will return an
    /// error
    /// and its details as an `introspectionStatusDetail`.
    introspection_status: ?DataSourceIntrospectionStatus = null,

    /// The error detail field. When a `FAILED`
    /// `introspectionStatus` is returned, the `introspectionStatusDetail`
    /// will also return the exact error that was generated during the operation.
    introspection_status_detail: ?[]const u8 = null,

    pub const json_field_names = .{
        .introspection_id = "introspectionId",
        .introspection_result = "introspectionResult",
        .introspection_status = "introspectionStatus",
        .introspection_status_detail = "introspectionStatusDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSourceIntrospectionInput, options: CallOptions) !GetDataSourceIntrospectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSourceIntrospectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/datasources/introspections/");
    try path_buf.appendSlice(allocator, input.introspection_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_models_sdl) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeModelsSDL=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSourceIntrospectionOutput {
    var result: GetDataSourceIntrospectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataSourceIntrospectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
