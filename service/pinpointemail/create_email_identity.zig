const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DkimAttributes = @import("dkim_attributes.zig").DkimAttributes;
const IdentityType = @import("identity_type.zig").IdentityType;

pub const CreateEmailIdentityInput = struct {
    /// The email address or domain that you want to verify.
    email_identity: []const u8,

    /// An array of objects that define the tags (keys and values) that you want to
    /// associate
    /// with the email identity.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .email_identity = "EmailIdentity",
        .tags = "Tags",
    };
};

pub const CreateEmailIdentityOutput = struct {
    /// An object that contains information about the DKIM attributes for the
    /// identity. This
    /// object includes the tokens that you use to create the CNAME records that are
    /// required to
    /// complete the DKIM verification process.
    dkim_attributes: ?DkimAttributes = null,

    /// The email identity type.
    identity_type: ?IdentityType = null,

    /// Specifies whether or not the identity is verified. In Amazon Pinpoint, you
    /// can only send email
    /// from verified email addresses or domains. For more information about
    /// verifying
    /// identities, see the [Amazon Pinpoint User
    /// Guide](https://docs.aws.amazon.com/pinpoint/latest/userguide/channels-email-manage-verify.html).
    verified_for_sending_status: ?bool = null,

    pub const json_field_names = .{
        .dkim_attributes = "DkimAttributes",
        .identity_type = "IdentityType",
        .verified_for_sending_status = "VerifiedForSendingStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEmailIdentityInput, options: CallOptions) !CreateEmailIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEmailIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/email/identities";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EmailIdentity\":");
    try aws.json.writeValue(@TypeOf(input.email_identity), input.email_identity, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEmailIdentityOutput {
    var result: CreateEmailIdentityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEmailIdentityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
