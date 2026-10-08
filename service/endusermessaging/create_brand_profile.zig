const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Status = @import("status.zig").Status;

pub const CreateBrandProfileInput = struct {
    /// The name of the brand profile. The name can contain alphanumeric characters,
    /// underscores, hyphens, and spaces.
    brand_profile_name: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you do not specify a client token, the AWS
    /// SDK automatically generates one.
    client_token: ?[]const u8 = null,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: ?bool = null,

    /// An array of key and value pair tags that are associated with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .brand_profile_name = "brandProfileName",
        .client_token = "clientToken",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .tags = "tags",
    };
};

pub const CreateBrandProfileOutput = struct {
    /// The number of default attributes that were created for the brand profile.
    attributes_created: i32,

    /// The Amazon Resource Name (ARN) of the brand profile.
    brand_profile_arn: []const u8,

    /// The unique identifier of the brand profile.
    brand_profile_id: []const u8,

    /// The name of the brand profile. The name can contain alphanumeric characters,
    /// underscores, hyphens, and spaces.
    brand_profile_name: []const u8,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: bool,

    /// The current lifecycle status of the brand profile.
    status: Status,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .attributes_created = "attributesCreated",
        .brand_profile_arn = "brandProfileArn",
        .brand_profile_id = "brandProfileId",
        .brand_profile_name = "brandProfileName",
        .created_at = "createdAt",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBrandProfileInput, options: CallOptions) !CreateBrandProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBrandProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/brand-profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"brandProfileName\":");
    try aws.json.writeValue(@TypeOf(input.brand_profile_name), input.brand_profile_name, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deletion_protection_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletionProtectionEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBrandProfileOutput {
    const result: CreateBrandProfileOutput = try aws.json.parseJsonObject(
        CreateBrandProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
