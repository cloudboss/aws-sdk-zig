const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionVersionLatestPublished = @import("function_version_latest_published.zig").FunctionVersionLatestPublished;
const Architecture = @import("architecture.zig").Architecture;
const CapacityProviderConfig = @import("capacity_provider_config.zig").CapacityProviderConfig;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const DurableConfig = @import("durable_config.zig").DurableConfig;
const EnvironmentResponse = @import("environment_response.zig").EnvironmentResponse;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;
const ImageConfigResponse = @import("image_config_response.zig").ImageConfigResponse;
const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;
const LastUpdateStatusReasonCode = @import("last_update_status_reason_code.zig").LastUpdateStatusReasonCode;
const Layer = @import("layer.zig").Layer;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const PackageType = @import("package_type.zig").PackageType;
const Runtime = @import("runtime.zig").Runtime;
const RuntimeVersionConfig = @import("runtime_version_config.zig").RuntimeVersionConfig;
const SnapStartResponse = @import("snap_start_response.zig").SnapStartResponse;
const State = @import("state.zig").State;
const StateReasonCode = @import("state_reason_code.zig").StateReasonCode;
const TenancyConfig = @import("tenancy_config.zig").TenancyConfig;
const TracingConfigResponse = @import("tracing_config_response.zig").TracingConfigResponse;
const VpcConfigResponse = @import("vpc_config_response.zig").VpcConfigResponse;

pub const PublishVersionInput = struct {
    /// Only publish a version if the hash value matches the value that's specified.
    /// Use this option to avoid publishing a version if the function code has
    /// changed since you last updated it. You can get the hash for the version that
    /// you uploaded from the output of UpdateFunctionCode.
    code_sha_256: ?[]const u8 = null,

    /// A description for the version to override the description in the function
    /// configuration.
    description: ?[]const u8 = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** - `MyFunction`.
    /// * **Function ARN** -
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction`.
    /// * **Partial ARN** - `123456789012:function:MyFunction`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Specifies where to publish the function version or configuration.
    publish_to: ?FunctionVersionLatestPublished = null,

    /// Only update the function if the revision ID matches the ID that's specified.
    /// Use this option to avoid publishing a version if the function configuration
    /// has changed since you last updated it.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_sha_256 = "CodeSha256",
        .description = "Description",
        .function_name = "FunctionName",
        .publish_to = "PublishTo",
        .revision_id = "RevisionId",
    };
};

pub const PublishVersionOutput = @import("function_configuration.zig").FunctionConfiguration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishVersionInput, options: CallOptions) !PublishVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.code_sha_256) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CodeSha256\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.publish_to) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PublishTo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevisionId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishVersionOutput {
    const result: PublishVersionOutput = try aws.json.parseJsonObject(
        PublishVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
