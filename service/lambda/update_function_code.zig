const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Architecture = @import("architecture.zig").Architecture;
const FunctionVersionLatestPublished = @import("function_version_latest_published.zig").FunctionVersionLatestPublished;
const S3ObjectStorageMode = @import("s3_object_storage_mode.zig").S3ObjectStorageMode;
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

pub const UpdateFunctionCodeInput = struct {
    /// The instruction set architecture that the function supports. Enter a string
    /// array with one of the valid values (arm64 or x86_64). The default value is
    /// `x86_64`.
    architectures: ?[]const Architecture = null,

    /// Set to true to validate the request parameters and access permissions
    /// without modifying the function code.
    dry_run: ?bool = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `my-function`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// URI of a container image in the Amazon ECR registry. Do not use for a
    /// function defined with a .zip file archive.
    image_uri: ?[]const u8 = null,

    /// Set to true to publish a new version of the function after updating the
    /// code. This has the same effect as calling PublishVersion separately.
    publish: ?bool = null,

    /// Specifies where to publish the function version or configuration.
    publish_to: ?FunctionVersionLatestPublished = null,

    /// Update the function only if the revision ID matches the ID that's specified.
    /// Use this option to avoid modifying a function that has changed since you
    /// last read it.
    revision_id: ?[]const u8 = null,

    /// An Amazon S3 bucket in the same Amazon Web Services Region as your function.
    /// The bucket can be in a different Amazon Web Services account. Use only with
    /// a function defined with a .zip file archive deployment package.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the deployment package. Use only with a function
    /// defined with a .zip file archive deployment package.
    s3_key: ?[]const u8 = null,

    /// Specifies how the deployment package is stored. Valid values:
    ///
    /// * `COPY` (default) – Uploads a copy of your deployment package to Lambda.
    /// * `REFERENCE` – Lambda references the deployment package from the specified
    ///   Amazon S3 bucket.
    s3_object_storage_mode: ?S3ObjectStorageMode = null,

    /// For versioned objects, the version of the deployment package object to use.
    s3_object_version: ?[]const u8 = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt your function's .zip deployment package. If you don't provide a
    /// customer managed key, Lambda uses an Amazon Web Services managed key.
    source_kms_key_arn: ?[]const u8 = null,

    /// The base64-encoded contents of the deployment package. Amazon Web Services
    /// SDK and CLI clients handle the encoding for you. Use only with a function
    /// defined with a .zip file archive deployment package.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .architectures = "Architectures",
        .dry_run = "DryRun",
        .function_name = "FunctionName",
        .image_uri = "ImageUri",
        .publish = "Publish",
        .publish_to = "PublishTo",
        .revision_id = "RevisionId",
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_object_storage_mode = "S3ObjectStorageMode",
        .s3_object_version = "S3ObjectVersion",
        .source_kms_key_arn = "SourceKMSKeyArn",
        .zip_file = "ZipFile",
    };
};

pub const UpdateFunctionCodeOutput = @import("function_configuration.zig").FunctionConfiguration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFunctionCodeInput, options: CallOptions) !UpdateFunctionCodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFunctionCodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/code");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.architectures) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Architectures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ImageUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.publish) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Publish\":");
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
    if (input.s3_bucket) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"S3Bucket\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s3_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"S3Key\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s3_object_storage_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"S3ObjectStorageMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s3_object_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"S3ObjectVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceKMSKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.zip_file) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ZipFile\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFunctionCodeOutput {
    const result: UpdateFunctionCodeOutput = try aws.json.parseJsonObject(
        UpdateFunctionCodeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
