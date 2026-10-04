const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMeetingWithAttendeesInput, options: CallOptions) !CreateMeetingWithAttendeesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMeetingWithAttendeesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("meetings-chime", "Chime SDK Meetings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/meetings";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=create-attendees");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Attendees\":");
    try aws.json.writeValue(@TypeOf(input.attendees), input.attendees, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExternalMeetingId\":");
    try aws.json.writeValue(@TypeOf(input.external_meeting_id), input.external_meeting_id, allocator, &body_buf);
    has_prev = true;
    if (input.media_placement_network_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaPlacementNetworkType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MediaRegion\":");
    try aws.json.writeValue(@TypeOf(input.media_region), input.media_region, allocator, &body_buf);
    has_prev = true;
    if (input.meeting_features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MeetingFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.meeting_host_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MeetingHostId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notifications_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NotificationsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.primary_meeting_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrimaryMeetingId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tenant_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TenantIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMeetingWithAttendeesOutput {
    const result: CreateMeetingWithAttendeesOutput = try aws.json.parseJsonObject(
        CreateMeetingWithAttendeesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
