const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrandProfileAttributeType = @import("brand_profile_attribute_type.zig").BrandProfileAttributeType;

pub const UpdateBrandProfileAttributeInput = struct {
    /// The binary content for an attribute of type IMAGE or DOCUMENT. The content
    /// is base64-encoded when it is sent over the wire.
    attachment_body: ?[]const u8 = null,

    /// The name of the brand profile attribute. The name is unique within a brand
    /// profile.
    attribute_name: []const u8,

    /// The text value of the attribute. This value applies to attributes of type
    /// TEXT.
    attribute_value: ?[]const u8 = null,

    /// The unique identifier of the brand profile. You can specify either the bare
    /// ID or the full Amazon Resource Name (ARN).
    brand_profile_id: []const u8,

    /// The category of the attribute.
    category: ?[]const u8 = null,

    /// A description of the attribute.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_body = "attachmentBody",
        .attribute_name = "attributeName",
        .attribute_value = "attributeValue",
        .brand_profile_id = "brandProfileId",
        .category = "category",
        .description = "description",
    };
};

pub const UpdateBrandProfileAttributeOutput = struct {
    /// The name of the brand profile attribute. The name is unique within a brand
    /// profile.
    attribute_name: []const u8,

    /// The type of the attribute. TEXT stores an inline value. IMAGE and DOCUMENT
    /// store binary media that you upload.
    attribute_type: BrandProfileAttributeType,

    /// The text value of the attribute. This value applies to attributes of type
    /// TEXT.
    attribute_value: ?[]const u8 = null,

    /// The category of the attribute.
    category: ?[]const u8 = null,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// A description of the attribute.
    description: ?[]const u8 = null,

    /// The MIME content type of the attribute media.
    media_content_type: ?[]const u8 = null,

    /// The size of the attribute media, in bytes.
    media_size_bytes: ?i64 = null,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .attribute_type = "attributeType",
        .attribute_value = "attributeValue",
        .category = "category",
        .created_at = "createdAt",
        .description = "description",
        .media_content_type = "mediaContentType",
        .media_size_bytes = "mediaSizeBytes",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBrandProfileAttributeInput, options: CallOptions) !UpdateBrandProfileAttributeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBrandProfileAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brand-profiles/");
    try path_buf.appendSlice(allocator, input.brand_profile_id);
    try path_buf.appendSlice(allocator, "/attributes/");
    try path_buf.appendSlice(allocator, input.attribute_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attachment_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attachmentBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attribute_value) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributeValue\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"category\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBrandProfileAttributeOutput {
    const result: UpdateBrandProfileAttributeOutput = try aws.json.parseJsonObject(
        UpdateBrandProfileAttributeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
