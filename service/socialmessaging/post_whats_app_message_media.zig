const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3File = @import("s3_file.zig").S3File;
const S3PresignedUrl = @import("s3_presigned_url.zig").S3PresignedUrl;

pub const PostWhatsAppMessageMediaInput = struct {
    /// The ID of the phone number to associate with the WhatsApp media file. The
    /// phone number
    /// identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`.
    /// Use
    /// [GetLinkedWhatsAppBusinessAccount](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_GetLinkedWhatsAppBusinessAccount.html)
    /// to find a phone number's id.
    origination_phone_number_id: []const u8,

    /// The source S3 url for the media file.
    source_s3_file: ?S3File = null,

    /// The source presign url of the media file.
    source_s3_presigned_url: ?S3PresignedUrl = null,

    pub const json_field_names = .{
        .origination_phone_number_id = "originationPhoneNumberId",
        .source_s3_file = "sourceS3File",
        .source_s3_presigned_url = "sourceS3PresignedUrl",
    };
};

pub const PostWhatsAppMessageMediaOutput = struct {
    /// The unique identifier of the posted WhatsApp message.
    media_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_id = "mediaId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostWhatsAppMessageMediaInput, options: CallOptions) !PostWhatsAppMessageMediaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PostWhatsAppMessageMediaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/media";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originationPhoneNumberId\":");
    try aws.json.writeValue(@TypeOf(input.origination_phone_number_id), input.origination_phone_number_id, allocator, &body_buf);
    has_prev = true;
    if (input.source_s3_file) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceS3File\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_s3_presigned_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceS3PresignedUrl\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PostWhatsAppMessageMediaOutput {
    var result: PostWhatsAppMessageMediaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PostWhatsAppMessageMediaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
