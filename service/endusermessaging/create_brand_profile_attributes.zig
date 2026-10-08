const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrandProfileAttributeInput = @import("brand_profile_attribute_input.zig").BrandProfileAttributeInput;
const BrandProfileAttributeOutput = @import("brand_profile_attribute_output.zig").BrandProfileAttributeOutput;

pub const CreateBrandProfileAttributesInput = struct {
    /// The brand profile attributes.
    attributes: []const BrandProfileAttributeInput,

    /// The unique identifier of the brand profile. You can specify either the bare
    /// ID or the full Amazon Resource Name (ARN).
    brand_profile_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you do not specify a client token, the AWS
    /// SDK automatically generates one.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .brand_profile_id = "brandProfileId",
        .client_token = "clientToken",
    };
};

pub const CreateBrandProfileAttributesOutput = struct {
    /// The brand profile attributes.
    attributes: ?[]const BrandProfileAttributeOutput = null,

    pub const json_field_names = .{
        .attributes = "attributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBrandProfileAttributesInput, options: CallOptions) !CreateBrandProfileAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBrandProfileAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brand-profiles/");
    try path_buf.appendSlice(allocator, input.brand_profile_id);
    try path_buf.appendSlice(allocator, "/attributes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"attributes\":");
    try aws.json.writeValue(@TypeOf(input.attributes), input.attributes, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBrandProfileAttributesOutput {
    const result: CreateBrandProfileAttributesOutput = try aws.json.parseJsonObject(
        CreateBrandProfileAttributesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
