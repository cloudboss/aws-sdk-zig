const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AudienceSizeConfig = @import("audience_size_config.zig").AudienceSizeConfig;
const TagOnCreatePolicy = @import("tag_on_create_policy.zig").TagOnCreatePolicy;
const ConfiguredAudienceModelOutputConfig = @import("configured_audience_model_output_config.zig").ConfiguredAudienceModelOutputConfig;
const SharedAudienceMetrics = @import("shared_audience_metrics.zig").SharedAudienceMetrics;

pub const CreateConfiguredAudienceModelInput = struct {
    /// The Amazon Resource Name (ARN) of the audience model to use for the
    /// configured audience model.
    audience_model_arn: []const u8,

    /// Configure the list of output sizes of audiences that can be created using
    /// this configured audience model. A request to StartAudienceGenerationJob that
    /// uses this configured audience model must have an `audienceSize` selected
    /// from this list. You can use the `ABSOLUTE` AudienceSize to configure out
    /// audience sizes using the count of identifiers in the output. You can use the
    /// `Percentage` AudienceSize to configure sizes in the range 1-100 percent.
    audience_size_config: ?AudienceSizeConfig = null,

    /// Configure how the service tags audience generation jobs created using this
    /// configured audience model. If you specify `NONE`, the tags from the
    /// StartAudienceGenerationJob request determine the tags of the audience
    /// generation job. If you specify `FROM_PARENT_RESOURCE`, the audience
    /// generation job inherits the tags from the configured audience model, by
    /// default. Tags in the StartAudienceGenerationJob will override the default.
    ///
    /// When the client is in a different account than the configured audience
    /// model, the tags from the client are never applied to a resource in the
    /// caller's account.
    child_resource_tag_on_create_policy: ?TagOnCreatePolicy = null,

    /// The description of the configured audience model.
    description: ?[]const u8 = null,

    /// The minimum number of users from the seed audience that must match with
    /// users in the training data of the audience model. The default value is 500.
    min_matching_seed_size: ?i32 = null,

    /// The name of the configured audience model.
    name: []const u8,

    /// Configure the Amazon S3 location and IAM Role for audiences created using
    /// this configured audience model. Each audience will have a unique location.
    /// The IAM Role must have `s3:PutObject` permission on the destination Amazon
    /// S3 location. If the destination is protected with Amazon S3 KMS-SSE, then
    /// the Role must also have the required KMS permissions.
    output_config: ConfiguredAudienceModelOutputConfig,

    /// Whether audience metrics are shared.
    shared_audience_metrics: []const SharedAudienceMetrics,

    /// The optional metadata that you apply to the resource to help you categorize
    /// and organize them. Each tag consists of a key and an optional value, both of
    /// which you define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case sensitive.
    /// * Do not use aws:, AWS:, or any upper or lowercase combination of such as a
    ///   prefix for keys as it is reserved for AWS use. You cannot edit or delete
    ///   tag keys with this prefix. Values can have this prefix. If a tag value has
    ///   aws as its prefix but the key does not, then Clean Rooms ML considers it
    ///   to be a user tag and will count against the limit of 50 tags. Tags with
    ///   only the key prefix of aws do not count against your tags per resource
    ///   limit.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .audience_model_arn = "audienceModelArn",
        .audience_size_config = "audienceSizeConfig",
        .child_resource_tag_on_create_policy = "childResourceTagOnCreatePolicy",
        .description = "description",
        .min_matching_seed_size = "minMatchingSeedSize",
        .name = "name",
        .output_config = "outputConfig",
        .shared_audience_metrics = "sharedAudienceMetrics",
        .tags = "tags",
    };
};

pub const CreateConfiguredAudienceModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model.
    configured_audience_model_arn: []const u8,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfiguredAudienceModelInput, options: CallOptions) !CreateConfiguredAudienceModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanrooms-ml");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfiguredAudienceModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/configured-audience-model";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"audienceModelArn\":");
    try aws.json.writeValue(@TypeOf(input.audience_model_arn), input.audience_model_arn, allocator, &body_buf);
    has_prev = true;
    if (input.audience_size_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"audienceSizeConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.child_resource_tag_on_create_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"childResourceTagOnCreatePolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_matching_seed_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"minMatchingSeedSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_config), input.output_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sharedAudienceMetrics\":");
    try aws.json.writeValue(@TypeOf(input.shared_audience_metrics), input.shared_audience_metrics, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfiguredAudienceModelOutput {
    var result: CreateConfiguredAudienceModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfiguredAudienceModelOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
