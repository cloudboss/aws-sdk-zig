const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RdsDataApiConfig = @import("rds_data_api_config.zig").RdsDataApiConfig;
const DataSourceIntrospectionStatus = @import("data_source_introspection_status.zig").DataSourceIntrospectionStatus;

pub const StartDataSourceIntrospectionInput = struct {
    /// The `rdsDataApiConfig` object data.
    rds_data_api_config: ?RdsDataApiConfig = null,

    pub const json_field_names = .{
        .rds_data_api_config = "rdsDataApiConfig",
    };
};

pub const StartDataSourceIntrospectionOutput = struct {
    /// The introspection ID. Each introspection contains a unique ID that can be
    /// used to
    /// reference the instrospection record.
    introspection_id: ?[]const u8 = null,

    /// The status of the introspection during creation. By default, when a new
    /// instrospection
    /// has been created, the status will be set to `PROCESSING`. Once the operation
    /// has
    /// been completed, the status will change to `SUCCESS` or `FAILED`
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
        .introspection_status = "introspectionStatus",
        .introspection_status_detail = "introspectionStatusDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataSourceIntrospectionInput, options: CallOptions) !StartDataSourceIntrospectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataSourceIntrospectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/datasources/introspections";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.rds_data_api_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"rdsDataApiConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataSourceIntrospectionOutput {
    const result: StartDataSourceIntrospectionOutput = try aws.json.parseJsonObject(
        StartDataSourceIntrospectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
