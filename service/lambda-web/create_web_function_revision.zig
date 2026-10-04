const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BuildConfig = @import("build_config.zig").BuildConfig;
const ServiceConfig = @import("service_config.zig").ServiceConfig;
const RevisionError = @import("revision_error.zig").RevisionError;
const RevisionState = @import("revision_state.zig").RevisionState;

pub const CreateWebFunctionRevisionInput = struct {
    /// The build configuration for the revision, including code location and
    /// runtime settings.
    build_config: BuildConfig,

    /// A description of the revision.
    description: ?[]const u8 = null,

    /// The name of the web function. You can specify the function name or the
    /// function ARN. The length constraint applies only to the full ARN. If you
    /// specify only the function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// The Amazon Resource Name (ARN) of the AWS Key Management Service (AWS KMS)
    /// key used to encrypt the revision's code and environment variables.
    kms_key_arn: ?[]const u8 = null,

    /// The service configuration for the revision, including execution role,
    /// timeout, and concurrency settings.
    service_config: ServiceConfig,

    pub const json_field_names = .{
        .build_config = "buildConfig",
        .description = "description",
        .function_name = "functionName",
        .kms_key_arn = "kmsKeyArn",
        .service_config = "serviceConfig",
    };
};

pub const CreateWebFunctionRevisionOutput = struct {
    build_config: ?BuildConfig = null,

    /// The date and time the revision was created.
    created_at: i64,

    /// The description of the revision.
    description: ?[]const u8 = null,

    /// A list of errors encountered during revision creation. This field is absent
    /// when the revision has no errors.
    errors: ?[]const RevisionError = null,

    /// The Amazon Resource Name (ARN) of the web function.
    function_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the AWS KMS key used to encrypt the
    /// revision's code and environment variables.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the revision.
    revision_arn: []const u8,

    /// The identifier of the revision.
    revision_id: []const u8,

    service_config: ?ServiceConfig = null,

    /// The current state of the revision.
    state: RevisionState,

    /// The reason for the current state of the revision.
    state_reason: []const u8,

    pub const json_field_names = .{
        .build_config = "buildConfig",
        .created_at = "createdAt",
        .description = "description",
        .errors = "errors",
        .function_arn = "functionArn",
        .kms_key_arn = "kmsKeyArn",
        .revision_arn = "revisionArn",
        .revision_id = "revisionId",
        .service_config = "serviceConfig",
        .state = "state",
        .state_reason = "stateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebFunctionRevisionInput, options: CallOptions) !CreateWebFunctionRevisionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebFunctionRevisionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-03-07/web-functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/revisions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"buildConfig\":");
    try aws.json.writeValue(@TypeOf(input.build_config), input.build_config, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceConfig\":");
    try aws.json.writeValue(@TypeOf(input.service_config), input.service_config, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebFunctionRevisionOutput {
    const result: CreateWebFunctionRevisionOutput = try aws.json.parseJsonObject(
        CreateWebFunctionRevisionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
