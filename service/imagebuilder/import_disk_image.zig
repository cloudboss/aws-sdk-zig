const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageLoggingConfiguration = @import("image_logging_configuration.zig").ImageLoggingConfiguration;
const RegisterImageOptions = @import("register_image_options.zig").RegisterImageOptions;
const WindowsConfiguration = @import("windows_configuration.zig").WindowsConfiguration;

pub const ImportDiskImageInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The description for your disk image import.
    description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants Image Builder access
    /// to perform workflow actions to import an image from a Microsoft ISO file.
    /// If you don't provide a role, Image Builder uses the Image Builder
    /// service-linked role in your
    /// account, and creates it if it doesn't exist.
    execution_role: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the infrastructure configuration resource
    /// that's used for
    /// launching the EC2 instance on which the ISO image is built.
    infrastructure_configuration_arn: []const u8,

    /// The CloudWatch Logs log group where Image Builder sends the import logs. If
    /// you
    /// specify a log group name outside of the `/aws/imagebuilder/`
    /// namespace, you must also provide an `executionRole` that has
    /// permission to write to that log group.
    logging_configuration: ?ImageLoggingConfiguration = null,

    /// The name of the image resource that's created from the import. Image Builder
    /// generates the image ARN from a normalized form of the name, so names that
    /// differ only in case, spaces, or underscores count as the same name. If an
    /// image with the same name and semantic version already exists in your
    /// account in the same Amazon Web Services Region, the import creates a new
    /// build version
    /// for it.
    name: []const u8,

    /// The operating system version for the imported image. The only supported
    /// value is `Microsoft Windows 11`.
    os_version: []const u8,

    /// The operating system platform for the imported image. Allowed values include
    /// the following: `Windows`.
    platform: []const u8,

    /// Configures Secure Boot and UEFI settings for the
    /// imported image.
    register_image_options: ?RegisterImageOptions = null,

    /// The semantic version to attach to the image that's created during the import
    /// process. This version follows the semantic version syntax.
    semantic_version: []const u8,

    /// Tags that are attached to image resources created from the import.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The `uri` of the ISO disk file that's stored in Amazon S3, in
    /// `s3://bucket/key` format. The key must end with the
    /// `.iso`, `.ISO`, or `.Iso` extension, and the
    /// bucket must be owned by the account that makes the request.
    uri: []const u8,

    /// Specifies Windows settings for ISO imports.
    windows_configuration: ?WindowsConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .execution_role = "executionRole",
        .infrastructure_configuration_arn = "infrastructureConfigurationArn",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .os_version = "osVersion",
        .platform = "platform",
        .register_image_options = "registerImageOptions",
        .semantic_version = "semanticVersion",
        .tags = "tags",
        .uri = "uri",
        .windows_configuration = "windowsConfiguration",
    };
};

pub const ImportDiskImageOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Image Builder image resource that this
    /// request created. The AMI
    /// doesn't exist yet when the response returns. The import runs asynchronously,
    /// and the output AMI appears in the image's output resources when the import
    /// completes.
    image_build_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .image_build_version_arn = "imageBuildVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportDiskImageInput, options: CallOptions) !ImportDiskImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportDiskImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ImportDiskImage";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"infrastructureConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.infrastructure_configuration_arn), input.infrastructure_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (input.logging_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"loggingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"osVersion\":");
    try aws.json.writeValue(@TypeOf(input.os_version), input.os_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"platform\":");
    try aws.json.writeValue(@TypeOf(input.platform), input.platform, allocator, &body_buf);
    has_prev = true;
    if (input.register_image_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"registerImageOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"semanticVersion\":");
    try aws.json.writeValue(@TypeOf(input.semantic_version), input.semantic_version, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"uri\":");
    try aws.json.writeValue(@TypeOf(input.uri), input.uri, allocator, &body_buf);
    has_prev = true;
    if (input.windows_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"windowsConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportDiskImageOutput {
    const result: ImportDiskImageOutput = try aws.json.parseJsonObject(
        ImportDiskImageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
