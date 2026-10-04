const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppSyncRuntime = @import("app_sync_runtime.zig").AppSyncRuntime;
const SyncConfig = @import("sync_config.zig").SyncConfig;
const FunctionConfiguration = @import("function_configuration.zig").FunctionConfiguration;

pub const CreateFunctionInput = struct {
    /// The GraphQL API ID.
    api_id: []const u8,

    /// The `function` code that contains the request and response functions. When
    /// code is used, the `runtime` is required. The `runtime` value must be
    /// `APPSYNC_JS`.
    code: ?[]const u8 = null,

    /// The `Function`
    /// `DataSource` name.
    data_source_name: []const u8,

    /// The `Function` description.
    description: ?[]const u8 = null,

    /// The `version` of the request mapping template. Currently, the supported
    /// value
    /// is 2018-05-29. Note that when using VTL and mapping templates, the
    /// `functionVersion` is required.
    function_version: ?[]const u8 = null,

    /// The maximum batching size for a resolver.
    max_batch_size: ?i32 = null,

    /// The `Function` name. The function name does not have to be unique.
    name: []const u8,

    /// The `Function` request mapping template. Functions support only the
    /// 2018-05-29 version of the request mapping template.
    request_mapping_template: ?[]const u8 = null,

    /// The `Function` response mapping template.
    response_mapping_template: ?[]const u8 = null,

    runtime: ?AppSyncRuntime = null,

    sync_config: ?SyncConfig = null,

    pub const json_field_names = .{
        .api_id = "apiId",
        .code = "code",
        .data_source_name = "dataSourceName",
        .description = "description",
        .function_version = "functionVersion",
        .max_batch_size = "maxBatchSize",
        .name = "name",
        .request_mapping_template = "requestMappingTemplate",
        .response_mapping_template = "responseMappingTemplate",
        .runtime = "runtime",
        .sync_config = "syncConfig",
    };
};

pub const CreateFunctionOutput = struct {
    /// The `Function` object.
    function_configuration: ?FunctionConfiguration = null,

    pub const json_field_names = .{
        .function_configuration = "functionConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFunctionInput, options: CallOptions) !CreateFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/functions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"code\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataSourceName\":");
    try aws.json.writeValue(@TypeOf(input.data_source_name), input.data_source_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.function_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"functionVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_batch_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxBatchSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.request_mapping_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestMappingTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_mapping_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseMappingTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.runtime) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"runtime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sync_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"syncConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFunctionOutput {
    const result: CreateFunctionOutput = try aws.json.parseJsonObject(
        CreateFunctionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
