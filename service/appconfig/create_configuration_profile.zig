const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Validator = @import("validator.zig").Validator;

pub const CreateConfigurationProfileInput = struct {
    /// The application ID.
    application_id: []const u8,

    /// A description of the configuration profile.
    description: ?[]const u8 = null,

    /// The identifier for an Key Management Service key to encrypt new
    /// configuration data
    /// versions in the AppConfig hosted configuration store. This attribute is only
    /// used
    /// for `hosted` configuration types. The identifier can be an KMS
    /// key ID, alias, or the Amazon Resource Name (ARN) of the key ID or alias. To
    /// encrypt data
    /// managed in other configuration stores, see the documentation for how to
    /// specify an KMS key for that particular service.
    kms_key_identifier: ?[]const u8 = null,

    /// A URI to locate the configuration. You can specify the following:
    ///
    /// * For the AppConfig hosted configuration store and for feature flags,
    /// specify `hosted`.
    ///
    /// * For an Amazon Web Services Systems Manager Parameter Store parameter,
    ///   specify either the parameter name in
    /// the format `ssm-parameter://` or the ARN.
    ///
    /// * For an Amazon Web Services
    /// CodePipeline pipeline, specify the URI in the following format:
    /// `codepipeline`://.
    ///
    /// * For an Secrets Manager secret, specify the URI in the following format:
    /// `secretsmanager`://.
    ///
    /// * For an Amazon S3 object, specify the URI in the following format:
    /// `s3:/// `. Here is an example:
    /// `s3://amzn-s3-demo-bucket/my-app/us-east-1/my-config.json`
    ///
    /// * For an SSM document, specify either the document name in the format
    /// `ssm-document://` or the Amazon Resource Name
    /// (ARN).
    location_uri: []const u8,

    /// A name for the configuration profile.
    name: []const u8,

    /// The ARN of an IAM role with permission to access the configuration at the
    /// specified
    /// `LocationUri`.
    ///
    /// A retrieval role ARN is not required for configurations stored in
    /// CodePipeline or the AppConfig hosted configuration store. It is required for
    /// all other sources that
    /// store your configuration.
    retrieval_role_arn: ?[]const u8 = null,

    /// Metadata to assign to the configuration profile. Tags help organize and
    /// categorize your
    /// AppConfig resources. Each tag consists of a key and an optional value, both
    /// of
    /// which you define.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of configurations contained in the profile. AppConfig supports
    /// `feature flags` and `freeform` configurations. We recommend you
    /// create feature flag configurations to enable or disable new features and
    /// freeform
    /// configurations to distribute configurations to an application. When calling
    /// this API, enter
    /// one of the following values for `Type`:
    ///
    /// `AWS.AppConfig.FeatureFlags`
    ///
    /// `AWS.Freeform`
    @"type": ?[]const u8 = null,

    /// A list of methods for validating the configuration.
    validators: ?[]const Validator = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .description = "Description",
        .kms_key_identifier = "KmsKeyIdentifier",
        .location_uri = "LocationUri",
        .name = "Name",
        .retrieval_role_arn = "RetrievalRoleArn",
        .tags = "Tags",
        .@"type" = "Type",
        .validators = "Validators",
    };
};

pub const CreateConfigurationProfileOutput = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The configuration profile description.
    description: ?[]const u8 = null,

    /// The configuration profile ID.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name of the Key Management Service key to encrypt new
    /// configuration
    /// data versions in the AppConfig hosted configuration store. This attribute is
    /// only
    /// used for `hosted` configuration types. To encrypt data managed in other
    /// configuration stores, see the documentation for how to specify an KMS key
    /// for that particular service.
    kms_key_arn: ?[]const u8 = null,

    /// The Key Management Service key identifier (key ID, key alias, or key ARN)
    /// provided when
    /// the resource was created or updated.
    kms_key_identifier: ?[]const u8 = null,

    /// The URI location of the configuration.
    location_uri: ?[]const u8 = null,

    /// The name of the configuration profile.
    name: ?[]const u8 = null,

    /// The ARN of an IAM role with permission to access the configuration at the
    /// specified
    /// `LocationUri`.
    retrieval_role_arn: ?[]const u8 = null,

    /// The type of configurations contained in the profile. AppConfig supports
    /// `feature flags` and `freeform` configurations. We recommend you
    /// create feature flag configurations to enable or disable new features and
    /// freeform
    /// configurations to distribute configurations to an application. When calling
    /// this API, enter
    /// one of the following values for `Type`:
    ///
    /// `AWS.AppConfig.FeatureFlags`
    ///
    /// `AWS.Freeform`
    @"type": ?[]const u8 = null,

    /// A list of methods for validating the configuration.
    validators: ?[]const Validator = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .description = "Description",
        .id = "Id",
        .kms_key_arn = "KmsKeyArn",
        .kms_key_identifier = "KmsKeyIdentifier",
        .location_uri = "LocationUri",
        .name = "Name",
        .retrieval_role_arn = "RetrievalRoleArn",
        .@"type" = "Type",
        .validators = "Validators",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationProfileInput, options: CallOptions) !CreateConfigurationProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfig");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/configurationprofiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LocationUri\":");
    try aws.json.writeValue(@TypeOf(input.location_uri), input.location_uri, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.retrieval_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RetrievalRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.validators) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Validators\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationProfileOutput {
    var result: CreateConfigurationProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfigurationProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PayloadTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .payload_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
