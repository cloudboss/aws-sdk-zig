const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SupportedS3Region = @import("supported_s3_region.zig").SupportedS3Region;
const AnalyticsEngine = @import("analytics_engine.zig").AnalyticsEngine;
const AutoApprovedChangeType = @import("auto_approved_change_type.zig").AutoApprovedChangeType;
const MemberAbility = @import("member_ability.zig").MemberAbility;
const MLMemberAbilities = @import("ml_member_abilities.zig").MLMemberAbilities;
const PaymentConfiguration = @import("payment_configuration.zig").PaymentConfiguration;
const DataEncryptionMetadata = @import("data_encryption_metadata.zig").DataEncryptionMetadata;
const CollaborationJobLogStatus = @import("collaboration_job_log_status.zig").CollaborationJobLogStatus;
const MemberSpecification = @import("member_specification.zig").MemberSpecification;
const CollaborationQueryLogStatus = @import("collaboration_query_log_status.zig").CollaborationQueryLogStatus;
const Collaboration = @import("collaboration.zig").Collaboration;

pub const CreateCollaborationInput = struct {
    /// The Amazon Web Services Regions where collaboration query results can be
    /// stored. When specified, results can only be written to these Regions. This
    /// parameter enables you to meet your compliance and data governance
    /// requirements, and implement regional data governance policies.
    allowed_result_regions: ?[]const SupportedS3Region = null,

    /// The analytics engine.
    ///
    /// After July 16, 2025, the `CLEAN_ROOMS_SQL` parameter will no longer be
    /// available.
    analytics_engine: ?AnalyticsEngine = null,

    /// The types of change requests that are automatically approved for this
    /// collaboration.
    auto_approved_change_request_types: ?[]const AutoApprovedChangeType = null,

    /// The display name of the collaboration creator.
    creator_display_name: []const u8,

    /// The abilities granted to the collaboration creator.
    creator_member_abilities: []const MemberAbility,

    /// The ML abilities granted to the collaboration creator.
    creator_ml_member_abilities: ?MLMemberAbilities = null,

    /// The collaboration creator's payment responsibilities set by the
    /// collaboration creator.
    ///
    /// If the collaboration creator hasn't specified anyone as the member paying
    /// for query compute costs, then the member who can query is the default payer.
    creator_payment_configuration: ?PaymentConfiguration = null,

    /// The settings for client-side encryption with Cryptographic Computing for
    /// Clean Rooms.
    data_encryption_metadata: ?DataEncryptionMetadata = null,

    /// A description of the collaboration provided by the collaboration owner.
    description: []const u8,

    /// An indicator as to whether metrics have been enabled or disabled for the
    /// collaboration.
    ///
    /// When `true`, collaboration members can opt in to Amazon CloudWatch metrics
    /// for their membership queries. The default value is `false`.
    is_metrics_enabled: ?bool = null,

    /// Specifies whether job logs are enabled for this collaboration.
    ///
    /// When `ENABLED`, Clean Rooms logs details about jobs run within this
    /// collaboration; those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    job_log_status: ?CollaborationJobLogStatus = null,

    /// A list of initial members, not including the creator. This list is
    /// immutable.
    members: []const MemberSpecification,

    /// The display name for a collaboration.
    name: []const u8,

    /// An indicator as to whether query logging has been enabled or disabled for
    /// the collaboration.
    ///
    /// When `ENABLED`, Clean Rooms logs details about queries run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    query_log_status: CollaborationQueryLogStatus,

    /// An optional label that you can assign to a resource when you create it. Each
    /// tag consists of a key and an optional value, both of which you define. When
    /// you use tagging, you can also use tag-based access control in IAM policies
    /// to control access to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allowed_result_regions = "allowedResultRegions",
        .analytics_engine = "analyticsEngine",
        .auto_approved_change_request_types = "autoApprovedChangeRequestTypes",
        .creator_display_name = "creatorDisplayName",
        .creator_member_abilities = "creatorMemberAbilities",
        .creator_ml_member_abilities = "creatorMLMemberAbilities",
        .creator_payment_configuration = "creatorPaymentConfiguration",
        .data_encryption_metadata = "dataEncryptionMetadata",
        .description = "description",
        .is_metrics_enabled = "isMetricsEnabled",
        .job_log_status = "jobLogStatus",
        .members = "members",
        .name = "name",
        .query_log_status = "queryLogStatus",
        .tags = "tags",
    };
};

pub const CreateCollaborationOutput = struct {
    /// The collaboration.
    collaboration: ?Collaboration = null,

    pub const json_field_names = .{
        .collaboration = "collaboration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCollaborationInput, options: CallOptions) !CreateCollaborationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanrooms");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCollaborationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/collaborations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_result_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedResultRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.analytics_engine) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"analyticsEngine\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_approved_change_request_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoApprovedChangeRequestTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"creatorDisplayName\":");
    try aws.json.writeValue(@TypeOf(input.creator_display_name), input.creator_display_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"creatorMemberAbilities\":");
    try aws.json.writeValue(@TypeOf(input.creator_member_abilities), input.creator_member_abilities, allocator, &body_buf);
    has_prev = true;
    if (input.creator_ml_member_abilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"creatorMLMemberAbilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.creator_payment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"creatorPaymentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_encryption_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataEncryptionMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (input.is_metrics_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isMetricsEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_log_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobLogStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"members\":");
    try aws.json.writeValue(@TypeOf(input.members), input.members, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryLogStatus\":");
    try aws.json.writeValue(@TypeOf(input.query_log_status), input.query_log_status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCollaborationOutput {
    var result: CreateCollaborationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCollaborationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
