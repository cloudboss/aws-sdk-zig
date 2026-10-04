const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppConfig = @import("app_config.zig").AppConfig;
const DataSource = @import("data_source.zig").DataSource;
const IamIdentityCenterOptionsInput = @import("iam_identity_center_options_input.zig").IamIdentityCenterOptionsInput;
const IamIdentityCenterOptions = @import("iam_identity_center_options.zig").IamIdentityCenterOptions;

pub const UpdateApplicationInput = struct {
    /// The configuration settings to modify for the OpenSearch application.
    app_configs: ?[]const AppConfig = null,

    /// The data sources to associate with the OpenSearch application.
    data_sources: ?[]const DataSource = null,

    /// Configuration settings for integrating IAM Identity Center with the
    /// OpenSearch
    /// application.
    iam_identity_center_options: ?IamIdentityCenterOptionsInput = null,

    /// The unique identifier for the OpenSearch application to be updated.
    id: []const u8,

    pub const json_field_names = .{
        .app_configs = "appConfigs",
        .data_sources = "dataSources",
        .iam_identity_center_options = "iamIdentityCenterOptions",
        .id = "id",
    };
};

pub const UpdateApplicationOutput = struct {
    /// The configuration settings for the updated OpenSearch application.
    app_configs: ?[]const AppConfig = null,

    arn: ?[]const u8 = null,

    /// The timestamp when the OpenSearch application was originally created.
    created_at: ?i64 = null,

    /// The data sources associated with the updated OpenSearch application.
    data_sources: ?[]const DataSource = null,

    /// The IAM Identity Center configuration for the updated OpenSearch
    /// application.
    iam_identity_center_options: ?IamIdentityCenterOptions = null,

    /// The unique identifier of the updated OpenSearch application.
    id: ?[]const u8 = null,

    /// The timestamp when the OpenSearch application was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the updated OpenSearch application.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_configs = "appConfigs",
        .arn = "arn",
        .created_at = "createdAt",
        .data_sources = "dataSources",
        .iam_identity_center_options = "iamIdentityCenterOptions",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationInput, options: CallOptions) !UpdateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/application/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.app_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"appConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataSources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iam_identity_center_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"iamIdentityCenterOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationOutput {
    const result: UpdateApplicationOutput = try aws.json.parseJsonObject(
        UpdateApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
