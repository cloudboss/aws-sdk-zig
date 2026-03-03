const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PrivacyBudgets = @import("privacy_budgets.zig").PrivacyBudgets;
const MLInputChannelStatus = @import("ml_input_channel_status.zig").MLInputChannelStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;
const SyntheticDataConfiguration = @import("synthetic_data_configuration.zig").SyntheticDataConfiguration;

pub const GetCollaborationMLInputChannelInput = struct {
    /// The collaboration ID of the collaboration that contains the ML input channel
    /// that you want to get.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the ML input channel that you want to get.
    ml_input_channel_arn: []const u8,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .ml_input_channel_arn = "mlInputChannelArn",
    };
};

pub const GetCollaborationMLInputChannelOutput = struct {
    /// The collaboration ID of the collaboration that contains the ML input
    /// channel.
    collaboration_identifier: []const u8,

    /// The configured model algorithm associations that were used to create the ML
    /// input channel.
    configured_model_algorithm_associations: ?[]const []const u8 = null,

    /// The time at which the ML input channel was created.
    create_time: i64,

    /// The account ID of the member who created the ML input channel.
    creator_account_id: []const u8,

    /// The description of the ML input channel.
    description: ?[]const u8 = null,

    /// The membership ID of the membership that contains the ML input channel.
    membership_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the ML input channel.
    ml_input_channel_arn: []const u8,

    /// The name of the ML input channel.
    name: []const u8,

    /// The number of records in the ML input channel.
    number_of_records: ?i64 = null,

    /// Returns the privacy budgets that control access to this Clean Rooms ML input
    /// channel. Use these budgets to monitor and limit resource consumption over
    /// specified time periods.
    privacy_budgets: ?PrivacyBudgets = null,

    /// The number of days to retain the data for the ML input channel.
    retention_in_days: i32,

    /// The status of the ML input channel.
    status: MLInputChannelStatus,

    status_details: ?StatusDetails = null,

    /// The synthetic data configuration for this ML input channel, including
    /// parameters for generating privacy-preserving synthetic data and evaluation
    /// scores for measuring the privacy of the generated data.
    synthetic_data_configuration: ?SyntheticDataConfiguration = null,

    /// The most recent time at which the ML input channel was updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_associations = "configuredModelAlgorithmAssociations",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
        .ml_input_channel_arn = "mlInputChannelArn",
        .name = "name",
        .number_of_records = "numberOfRecords",
        .privacy_budgets = "privacyBudgets",
        .retention_in_days = "retentionInDays",
        .status = "status",
        .status_details = "statusDetails",
        .synthetic_data_configuration = "syntheticDataConfiguration",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCollaborationMLInputChannelInput, options: CallOptions) !GetCollaborationMLInputChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanroomsml");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCollaborationMLInputChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanroomsml", "CleanRoomsML", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/ml-input-channels/");
    try path_buf.appendSlice(allocator, input.ml_input_channel_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCollaborationMLInputChannelOutput {
    var result: GetCollaborationMLInputChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCollaborationMLInputChannelOutput, body, allocator);
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
