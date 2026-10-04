const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DkimAttributes = @import("dkim_attributes.zig").DkimAttributes;
const IdentityType = @import("identity_type.zig").IdentityType;
const MailFromAttributes = @import("mail_from_attributes.zig").MailFromAttributes;
const Tag = @import("tag.zig").Tag;
const VerificationInfo = @import("verification_info.zig").VerificationInfo;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;

pub const GetEmailIdentityInput = struct {
    /// The email identity.
    email_identity: []const u8,

    pub const json_field_names = .{
        .email_identity = "EmailIdentity",
    };
};

pub const GetEmailIdentityOutput = struct {
    /// The configuration set used by default when sending from this identity.
    configuration_set_name: ?[]const u8 = null,

    /// An object that contains information about the DKIM attributes for the
    /// identity.
    dkim_attributes: ?DkimAttributes = null,

    /// The feedback forwarding configuration for the identity.
    ///
    /// If the value is `true`, you receive email notifications when bounce or
    /// complaint events occur. These notifications are sent to the address that you
    /// specified
    /// in the `Return-Path` header of the original email.
    ///
    /// You're required to have a method of tracking bounces and complaints. If you
    /// haven't
    /// set up another mechanism for receiving bounce or complaint notifications
    /// (for example,
    /// by setting up an event destination), you receive an email notification when
    /// these events
    /// occur (even if this setting is disabled).
    feedback_forwarding_status: ?bool = null,

    /// The email identity type. Note: the `MANAGED_DOMAIN` identity type is not
    /// supported.
    identity_type: ?IdentityType = null,

    /// An object that contains information about the Mail-From attributes for the
    /// email
    /// identity.
    mail_from_attributes: ?MailFromAttributes = null,

    /// A map of policy names to policies.
    policies: ?[]const aws.map.StringMapEntry = null,

    /// An array of objects that define the tags (keys and values) that are
    /// associated with
    /// the email identity.
    tags: ?[]const Tag = null,

    /// An object that contains additional information about the verification status
    /// for the
    /// identity.
    verification_info: ?VerificationInfo = null,

    /// The verification status of the identity. The status can be one of the
    /// following:
    ///
    /// * `PENDING` – The verification process was initiated, but Amazon SES
    /// hasn't yet been able to verify the identity.
    ///
    /// * `SUCCESS` – The verification process completed
    /// successfully.
    ///
    /// * `FAILED` – The verification process failed.
    ///
    /// * `TEMPORARY_FAILURE` – A temporary issue is preventing Amazon SES
    /// from determining the verification status of the identity.
    ///
    /// * `NOT_STARTED` – The verification process hasn't been
    /// initiated for the identity.
    verification_status: ?VerificationStatus = null,

    /// Specifies whether or not the identity is verified. You can only send email
    /// from
    /// verified email addresses or domains. For more information about verifying
    /// identities,
    /// see the [Amazon Pinpoint User
    /// Guide](https://docs.aws.amazon.com/pinpoint/latest/userguide/channels-email-manage-verify.html).
    verified_for_sending_status: ?bool = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .dkim_attributes = "DkimAttributes",
        .feedback_forwarding_status = "FeedbackForwardingStatus",
        .identity_type = "IdentityType",
        .mail_from_attributes = "MailFromAttributes",
        .policies = "Policies",
        .tags = "Tags",
        .verification_info = "VerificationInfo",
        .verification_status = "VerificationStatus",
        .verified_for_sending_status = "VerifiedForSendingStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEmailIdentityInput, options: CallOptions) !GetEmailIdentityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEmailIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/identities/");
    try path_buf.appendSlice(allocator, input.email_identity);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEmailIdentityOutput {
    var result: GetEmailIdentityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEmailIdentityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
