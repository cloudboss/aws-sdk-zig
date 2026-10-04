const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DkimSigningAttributes = @import("dkim_signing_attributes.zig").DkimSigningAttributes;
const Tag = @import("tag.zig").Tag;
const DkimAttributes = @import("dkim_attributes.zig").DkimAttributes;
const IdentityType = @import("identity_type.zig").IdentityType;

pub const CreateEmailIdentityInput = struct {
    /// The configuration set to use by default when sending from this identity.
    /// Note that any
    /// configuration set defined in the email sending request takes precedence.
    configuration_set_name: ?[]const u8 = null,

    /// If your request includes this object, Amazon SES configures the identity to
    /// use Bring Your
    /// Own DKIM (BYODKIM) for DKIM authentication purposes, or, configures the key
    /// length to be
    /// used for [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html).
    ///
    /// You can only specify this object if the email identity is a domain, as
    /// opposed to an
    /// address.
    dkim_signing_attributes: ?DkimSigningAttributes = null,

    /// The email address or domain to verify.
    email_identity: []const u8,

    /// An array of objects that define the tags (keys and values) to associate with
    /// the email
    /// identity.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .dkim_signing_attributes = "DkimSigningAttributes",
        .email_identity = "EmailIdentity",
        .tags = "Tags",
    };
};

pub const CreateEmailIdentityOutput = struct {
    /// An object that contains information about the DKIM attributes for the
    /// identity.
    dkim_attributes: ?DkimAttributes = null,

    /// The email identity type. Note: the `MANAGED_DOMAIN` identity type is not
    /// supported.
    identity_type: ?IdentityType = null,

    /// Specifies whether or not the identity is verified. You can only send email
    /// from
    /// verified email addresses or domains. For more information about verifying
    /// identities,
    /// see the [Amazon Pinpoint User
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
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/identities";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dkim_signing_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DkimSigningAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
