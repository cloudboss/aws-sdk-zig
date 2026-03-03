const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ParticipantType = @import("participant_type.zig").ParticipantType;
const EngagementInvitationPayloadType = @import("engagement_invitation_payload_type.zig").EngagementInvitationPayloadType;
const OpportunityEngagementInvitationSort = @import("opportunity_engagement_invitation_sort.zig").OpportunityEngagementInvitationSort;
const InvitationStatus = @import("invitation_status.zig").InvitationStatus;
const EngagementInvitationSummary = @import("engagement_invitation_summary.zig").EngagementInvitationSummary;

pub const ListEngagementInvitationsInput = struct {
    /// Specifies the catalog from which to list the engagement invitations. Use
    /// `AWS` for production invitations or `Sandbox` for testing environments.
    catalog: []const u8,

    /// Retrieves a list of engagement invitation summaries based on specified
    /// filters. The ListEngagementInvitations operation allows you to view all
    /// invitations that you have sent or received. You must specify the
    /// ParticipantType to filter invitations where you are either the SENDER or the
    /// RECEIVER. Invitations will automatically expire if not accepted within 15
    /// days.
    engagement_identifier: ?[]const []const u8 = null,

    /// Specifies the maximum number of engagement invitations to return in the
    /// response. If more results are available, a pagination token will be
    /// provided.
    max_results: ?i32 = null,

    /// A pagination token used to retrieve additional pages of results when the
    /// response to a previous request was truncated. Pass this token to continue
    /// listing invitations from where the previous call left off.
    next_token: ?[]const u8 = null,

    /// Specifies the type of participant for which to list engagement invitations.
    /// Identifies the role of the participant.
    participant_type: ParticipantType,

    /// Defines the type of payload associated with the engagement invitations to be
    /// listed. The attributes in this payload help decide on acceptance or
    /// rejection of the invitation.
    payload_type: ?[]const EngagementInvitationPayloadType = null,

    /// List of sender AWS account IDs to filter the invitations.
    sender_aws_account_id: ?[]const []const u8 = null,

    /// Specifies the sorting options for listing engagement invitations.
    /// Invitations can be sorted by fields such as `InvitationDate` or `Status` to
    /// help partners view results in their preferred order.
    sort: ?OpportunityEngagementInvitationSort = null,

    /// Status values to filter the invitations.
    status: ?[]const InvitationStatus = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .engagement_identifier = "EngagementIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .participant_type = "ParticipantType",
        .payload_type = "PayloadType",
        .sender_aws_account_id = "SenderAwsAccountId",
        .sort = "Sort",
        .status = "Status",
    };
};

pub const ListEngagementInvitationsOutput = struct {
    /// An array containing summaries of engagement invitations. Each summary
    /// includes information such as the invitation title, invitation date, and the
    /// current status of the invitation.
    engagement_invitation_summaries: ?[]const EngagementInvitationSummary = null,

    /// A pagination token returned when there are more results available than can
    /// be returned in a single call. Use this token to retrieve additional pages of
    /// engagement invitation summaries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engagement_invitation_summaries = "EngagementInvitationSummaries",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementInvitationsInput, options: Options) !ListEngagementInvitationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementInvitationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagementInvitations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementInvitationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEngagementInvitationsOutput, body, allocator);
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
