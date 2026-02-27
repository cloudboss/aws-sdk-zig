const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CreateAttendeeRequestItem = @import("create_attendee_request_item.zig").CreateAttendeeRequestItem;
const MediaPlacementNetworkType = @import("media_placement_network_type.zig").MediaPlacementNetworkType;
const MeetingFeaturesConfiguration = @import("meeting_features_configuration.zig").MeetingFeaturesConfiguration;
const NotificationsConfiguration = @import("notifications_configuration.zig").NotificationsConfiguration;
const Tag = @import("tag.zig").Tag;
const Attendee = @import("attendee.zig").Attendee;
const CreateAttendeeError = @import("create_attendee_error.zig").CreateAttendeeError;
const Meeting = @import("meeting.zig").Meeting;

pub const CreateMeetingWithAttendeesInput = struct {
    /// The attendee information, including attendees' IDs and join tokens.
    attendees: []const CreateAttendeeRequestItem,

    /// The unique identifier for the client request. Use a different token for
    /// different meetings.
    client_request_token: []const u8,

    /// The external meeting ID.
    ///
    /// Pattern: `[-_&@+=,(){}\[\]\/«».:|'"#a-zA-Z0-9À-ÿ\s]*`
    ///
    /// Values that begin with `aws:` are reserved. You can't configure a value that
    /// uses this prefix.
    /// Case insensitive.
    external_meeting_id: []const u8,

    /// The type of network for the media placement. Either IPv4 only or dual-stack
    /// (IPv4 and IPv6).
    media_placement_network_type: ?MediaPlacementNetworkType = null,

    /// The Region in which to create the meeting.
    ///
    /// Available values:
    /// `af-south-1`,
    /// `ap-northeast-1`,
    /// `ap-northeast-2`,
    /// `ap-south-1`,
    /// `ap-southeast-1`,
    /// `ap-southeast-2`,
    /// `ca-central-1`,
    /// `eu-central-1`,
    /// `eu-north-1`,
    /// `eu-south-1`,
    /// `eu-west-1`,
    /// `eu-west-2`,
    /// `eu-west-3`,
    /// `sa-east-1`,
    /// `us-east-1`,
    /// `us-east-2`,
    /// `us-west-1`,
    /// `us-west-2`.
    ///
    /// Available values in Amazon Web Services GovCloud (US) Regions:
    /// `us-gov-east-1`, `us-gov-west-1`.
    media_region: []const u8,

    /// Lists the audio and video features enabled for a meeting, such as echo
    /// reduction.
    meeting_features: ?MeetingFeaturesConfiguration = null,

    /// Reserved.
    meeting_host_id: ?[]const u8 = null,

    /// The configuration for resource targets to receive notifications when meeting
    /// and attendee events occur.
    notifications_configuration: ?NotificationsConfiguration = null,

    /// When specified, replicates the media from the primary meeting to the new
    /// meeting.
    primary_meeting_id: ?[]const u8 = null,

    /// The tags in the request.
    tags: ?[]const Tag = null,

    /// A consistent and opaque identifier, created and maintained by the builder to
    /// represent a segment of their users.
    tenant_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attendees = "Attendees",
        .client_request_token = "ClientRequestToken",
        .external_meeting_id = "ExternalMeetingId",
        .media_placement_network_type = "MediaPlacementNetworkType",
        .media_region = "MediaRegion",
        .meeting_features = "MeetingFeatures",
        .meeting_host_id = "MeetingHostId",
        .notifications_configuration = "NotificationsConfiguration",
        .primary_meeting_id = "PrimaryMeetingId",
        .tags = "Tags",
        .tenant_ids = "TenantIds",
    };
};

pub const CreateMeetingWithAttendeesOutput = struct {
    /// The attendee information, including attendees' IDs and join tokens.
    attendees: ?[]const Attendee = null,

    /// If the action fails for one or more of the attendees in the request, a list
    /// of the attendees is returned, along with error codes and error messages.
    errors: ?[]const CreateAttendeeError = null,

    /// The meeting information, including the meeting ID and
    /// `MediaPlacement`.
    meeting: ?Meeting = null,

    pub const json_field_names = .{
        .attendees = "Attendees",
        .errors = "Errors",
        .meeting = "Meeting",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMeetingWithAttendeesInput, options: Options) !CreateMeetingWithAttendeesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "chimesdkmeetings");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateMeetingWithAttendeesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chimesdkmeetings", "Chime SDK Meetings", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/meetings";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "operation=create-attendees");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Attendees\":");
    try aws.json.writeValue(@TypeOf(input.attendees), input.attendees, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ExternalMeetingId\":");
    try aws.json.writeValue(@TypeOf(input.external_meeting_id), input.external_meeting_id, alloc, &body_buf);
    has_prev = true;
    if (input.media_placement_network_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MediaPlacementNetworkType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"MediaRegion\":");
    try aws.json.writeValue(@TypeOf(input.media_region), input.media_region, alloc, &body_buf);
    has_prev = true;
    if (input.meeting_features) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MeetingFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.meeting_host_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MeetingHostId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.notifications_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"NotificationsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.primary_meeting_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PrimaryMeetingId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tenant_ids) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TenantIds\":");
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
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateMeetingWithAttendeesOutput {
    var result: CreateMeetingWithAttendeesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMeetingWithAttendeesOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
