const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConfiguredAudienceModelAssociation = @import("configured_audience_model_association.zig").ConfiguredAudienceModelAssociation;

pub const CreateConfiguredAudienceModelAssociationInput = struct {
    /// A unique identifier for the configured audience model that you want to
    /// associate.
    configured_audience_model_arn: []const u8,

    /// The name of the configured audience model association.
    configured_audience_model_association_name: []const u8,

    /// A description of the configured audience model association.
    description: ?[]const u8 = null,

    /// When `TRUE`, indicates that the resource policy for the configured audience
    /// model resource being associated is configured for Clean Rooms to manage
    /// permissions related to the given collaboration. When `FALSE`, indicates that
    /// the configured audience model resource owner will manage permissions related
    /// to the given collaboration.
    ///
    /// Setting this to `TRUE` requires you to have permissions to create, update,
    /// and delete the resource policy for the `cleanrooms-ml` resource when you
    /// call the DeleteConfiguredAudienceModelAssociation resource. In addition, if
    /// you are the collaboration creator and specify `TRUE`, you must have the same
    /// permissions when you call the DeleteMember and DeleteCollaboration APIs.
    manage_resource_policies: bool,

    /// A unique identifier for one of your memberships for a collaboration. The
    /// configured audience model is associated to the collaboration that this
    /// membership belongs to. Accepts a membership ID.
    membership_identifier: []const u8,

    /// An optional label that you can assign to a resource when you create it. Each
    /// tag consists of a key and an optional value, both of which you define. When
    /// you use tagging, you can also use tag-based access control in IAM policies
    /// to control access to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .configured_audience_model_association_name = "configuredAudienceModelAssociationName",
        .description = "description",
        .manage_resource_policies = "manageResourcePolicies",
        .membership_identifier = "membershipIdentifier",
        .tags = "tags",
    };
};

pub const CreateConfiguredAudienceModelAssociationOutput = struct {
    /// Information about the configured audience model association.
    configured_audience_model_association: ?ConfiguredAudienceModelAssociation = null,

    pub const json_field_names = .{
        .configured_audience_model_association = "configuredAudienceModelAssociation",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfiguredAudienceModelAssociationInput, options: Options) !CreateConfiguredAudienceModelAssociationOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateConfiguredAudienceModelAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/memberships/");
    try path_buf.appendSlice(alloc, input.membership_identifier);
    try path_buf.appendSlice(alloc, "/configuredaudiencemodelassociations");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"configuredAudienceModelArn\":");
    try aws.json.writeValue(@TypeOf(input.configured_audience_model_arn), input.configured_audience_model_arn, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"configuredAudienceModelAssociationName\":");
    try aws.json.writeValue(@TypeOf(input.configured_audience_model_association_name), input.configured_audience_model_association_name, alloc, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"manageResourcePolicies\":");
    try aws.json.writeValue(@TypeOf(input.manage_resource_policies), input.manage_resource_policies, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateConfiguredAudienceModelAssociationOutput {
    var result: CreateConfiguredAudienceModelAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConfiguredAudienceModelAssociationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
