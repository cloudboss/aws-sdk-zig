const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SupportedEmailDomainsParameters = @import("supported_email_domains_parameters.zig").SupportedEmailDomainsParameters;
const TierLevel = @import("tier_level.zig").TierLevel;

pub const UpdateSpaceInput = struct {
    /// A description for the private re:Post. This is used only to help you
    /// identify this private re:Post.
    description: ?[]const u8 = null,

    /// The IAM role that grants permissions to the private re:Post to convert
    /// unanswered questions into AWS support tickets.
    role_arn: ?[]const u8 = null,

    /// The unique ID of this private re:Post.
    space_id: []const u8,

    supported_email_domains: ?SupportedEmailDomainsParameters = null,

    /// The pricing tier of this private re:Post.
    tier: ?TierLevel = null,

    pub const json_field_names = .{
        .description = "description",
        .role_arn = "roleArn",
        .space_id = "spaceId",
        .supported_email_domains = "supportedEmailDomains",
        .tier = "tier",
    };
};

pub const UpdateSpaceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSpaceInput, options: CallOptions) !UpdateSpaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "repostspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("repostspace", "repostspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/spaces/");
    try path_buf.appendSlice(allocator, input.space_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.supported_email_domains) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"supportedEmailDomains\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSpaceOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateSpaceOutput = .{};

    return result;
}
