const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Reservation = @import("reservation.zig").Reservation;

pub const ListReservationsInput = struct {
    /// Filter by channel class, 'STANDARD' or 'SINGLE_PIPELINE'
    channel_class: ?[]const u8 = null,

    /// Filter by codec, 'AVC', 'HEVC', 'MPEG2', 'AUDIO', 'LINK', or 'AV1'
    codec: ?[]const u8 = null,

    /// Filter by bitrate, 'MAX_10_MBPS', 'MAX_20_MBPS', or 'MAX_50_MBPS'
    maximum_bitrate: ?[]const u8 = null,

    /// Filter by framerate, 'MAX_30_FPS' or 'MAX_60_FPS'
    maximum_framerate: ?[]const u8 = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Filter by resolution, 'SD', 'HD', 'FHD', or 'UHD'
    resolution: ?[]const u8 = null,

    /// Filter by resource type, 'INPUT', 'OUTPUT', 'MULTIPLEX', or 'CHANNEL'
    resource_type: ?[]const u8 = null,

    /// Filter by special feature, 'ADVANCED_AUDIO' or 'AUDIO_NORMALIZATION'
    special_feature: ?[]const u8 = null,

    /// Filter by video quality, 'STANDARD', 'ENHANCED', or 'PREMIUM'
    video_quality: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_class = "ChannelClass",
        .codec = "Codec",
        .maximum_bitrate = "MaximumBitrate",
        .maximum_framerate = "MaximumFramerate",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resolution = "Resolution",
        .resource_type = "ResourceType",
        .special_feature = "SpecialFeature",
        .video_quality = "VideoQuality",
    };
};

pub const ListReservationsOutput = struct {
    /// Token to retrieve the next page of results
    next_token: ?[]const u8 = null,

    /// List of reservations
    reservations: ?[]const Reservation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .reservations = "Reservations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReservationsInput, options: CallOptions) !ListReservationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReservationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prod/reservations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.channel_class) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "channelClass=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.codec) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "codec=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.maximum_bitrate) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maximumBitrate=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.maximum_framerate) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maximumFramerate=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resolution) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resolution=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.special_feature) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "specialFeature=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.video_quality) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "videoQuality=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReservationsOutput {
    var result: ListReservationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListReservationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
