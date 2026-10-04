const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const HandshakeParty = @import("handshake_party.zig").HandshakeParty;
const Handshake = @import("handshake.zig").Handshake;

pub const InviteAccountToOrganizationInput = struct {
    /// Additional information that you want to include in the generated email to
    /// the
    /// recipient account owner.
    notes: ?[]const u8 = null,

    /// A list of tags that you want to attach to the account when it becomes a
    /// member of the
    /// organization. For each tag in the list, you must specify both a tag key and
    /// a value. You
    /// can set the value to an empty string, but you can't set it to `null`. For
    /// more information about tagging, see [Tagging Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the
    /// Organizations User Guide.
    ///
    /// Any tags in the request are checked for compliance with any applicable tag
    /// policies when the request is made. The request is rejected if the tags in
    /// the
    /// request don't match the requirements of the policy at that time. Tag policy
    /// compliance is *
    /// **not**
    /// * checked
    /// again when the invitation is accepted and the tags are actually attached to
    /// the
    /// account. That means that if the tag policy changes between the invitation
    /// and the
    /// acceptance, then that tags could potentially be non-compliant.
    ///
    /// If any one of the tags is not valid or if you exceed the allowed number of
    /// tags
    /// for an account, then the entire request fails and invitations are not sent.
    tags: ?[]const Tag = null,

    /// The identifier (ID) of the Amazon Web Services account that you want to
    /// invite to join your
    /// organization. This is a JSON object that contains the following elements:
    ///
    /// `{ "Type": "ACCOUNT", "Id": "" }`
    ///
    /// If you use the CLI, you can submit this as a single string, similar to the
    /// following
    /// example:
    ///
    /// `--target Id=123456789012,Type=ACCOUNT`
    ///
    /// If you specify `"Type": "ACCOUNT"`, you must provide the Amazon Web Services
    /// account ID
    /// number as the `Id`. If you specify `"Type": "EMAIL"`, you must
    /// specify the email address that is associated with the account.
    ///
    /// `--target Id=diego@example.com,Type=EMAIL`
    target: HandshakeParty,

    pub const json_field_names = .{
        .notes = "Notes",
        .tags = "Tags",
        .target = "Target",
    };
};

pub const InviteAccountToOrganizationOutput = struct {
    /// A structure that contains details about the handshake that is created to
    /// support this
    /// invitation request.
    handshake: ?Handshake = null,

    pub const json_field_names = .{
        .handshake = "Handshake",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InviteAccountToOrganizationInput, options: CallOptions) !InviteAccountToOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InviteAccountToOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.InviteAccountToOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InviteAccountToOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(InviteAccountToOrganizationOutput, body, allocator);
}
