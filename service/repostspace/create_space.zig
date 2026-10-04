const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SupportedEmailDomainsParameters = @import("supported_email_domains_parameters.zig").SupportedEmailDomainsParameters;
const TierLevel = @import("tier_level.zig").TierLevel;

pub const CreateSpaceInput = struct {
    /// A description for the private re:Post. This is used only to help you
    /// identify this private re:Post.
    description: ?[]const u8 = null,

    /// The name for the private re:Post. This must be unique in your account.
    name: []const u8,

    /// The IAM role that grants permissions to the private re:Post to convert
    /// unanswered questions into AWS support tickets.
    role_arn: ?[]const u8 = null,

    /// The subdomain that you use to access your AWS re:Post Private private
    /// re:Post. All custom subdomains must be approved by AWS before use. In
    /// addition to your custom subdomain, all private re:Posts are issued an AWS
    /// generated subdomain for immediate use.
    subdomain: []const u8,

    supported_email_domains: ?SupportedEmailDomainsParameters = null,

    /// The list of tags associated with the private re:Post.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The pricing tier for the private re:Post.
    tier: TierLevel,

    /// The AWS KMS key ARN that’s used for the AWS KMS encryption. If you don't
    /// provide a key, your data is encrypted by default with a key that AWS owns
    /// and manages for you.
    user_kms_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .role_arn = "roleArn",
        .subdomain = "subdomain",
        .supported_email_domains = "supportedEmailDomains",
        .tags = "tags",
        .tier = "tier",
        .user_kms_key = "userKMSKey",
    };
};

pub const CreateSpaceOutput = struct {
    /// The unique ID of the private re:Post.
    space_id: []const u8,

    pub const json_field_names = .{
        .space_id = "spaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSpaceInput, options: CallOptions) !CreateSpaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("repostspace", "repostspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/spaces";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subdomain\":");
    try aws.json.writeValue(@TypeOf(input.subdomain), input.subdomain, allocator, &body_buf);
    has_prev = true;
    if (input.supported_email_domains) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"supportedEmailDomains\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tier\":");
    try aws.json.writeValue(@TypeOf(input.tier), input.tier, allocator, &body_buf);
    has_prev = true;
    if (input.user_kms_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userKMSKey\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSpaceOutput {
    var result: CreateSpaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSpaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
