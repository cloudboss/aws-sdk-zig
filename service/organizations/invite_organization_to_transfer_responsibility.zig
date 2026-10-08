const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const HandshakeParty = @import("handshake_party.zig").HandshakeParty;
const ResponsibilityTransferType = @import("responsibility_transfer_type.zig").ResponsibilityTransferType;
const Handshake = @import("handshake.zig").Handshake;

pub const InviteOrganizationToTransferResponsibilityInput = struct {
    /// Additional information that you want to include in the invitation.
    notes: ?[]const u8 = null,

    /// Name you want to assign to the transfer.
    source_name: []const u8,

    /// Timestamp when the recipient will begin managing the specified
    /// responsibilities.
    start_timestamp: i64,

    /// A list of tags that you want to attach to the transfer. For each tag in the
    /// list, you must specify both a tag key and a value. You
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
    /// transfer. That means that if the tag policy changes between the invitation
    /// and the
    /// acceptance, then that tags could potentially be non-compliant.
    ///
    /// If any one of the tags is not valid or if you exceed the allowed number of
    /// tags
    /// for a transfer, then the entire request fails and invitations are not sent.
    tags: ?[]const Tag = null,

    /// A `HandshakeParty` object. Contains details for the account you want to
    /// invite. Currently, only `ACCOUNT` and `EMAIL` are supported.
    target: HandshakeParty,

    /// The type of responsibility you want to designate to your organization.
    /// Currently, only
    /// `BILLING` is supported.
    type: ResponsibilityTransferType,

    pub const json_field_names = .{
        .notes = "Notes",
        .source_name = "SourceName",
        .start_timestamp = "StartTimestamp",
        .tags = "Tags",
        .target = "Target",
        .type = "Type",
    };
};

pub const InviteOrganizationToTransferResponsibilityOutput = struct {
    handshake: ?Handshake = null,

    pub const json_field_names = .{
        .handshake = "Handshake",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InviteOrganizationToTransferResponsibilityInput, options: CallOptions) !InviteOrganizationToTransferResponsibilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: InviteOrganizationToTransferResponsibilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.InviteOrganizationToTransferResponsibility");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InviteOrganizationToTransferResponsibilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(InviteOrganizationToTransferResponsibilityOutput, body, allocator);
}
