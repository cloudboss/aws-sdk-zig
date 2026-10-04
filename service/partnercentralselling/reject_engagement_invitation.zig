const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RejectEngagementInvitationInput = struct {
    /// This is the catalog that's associated with the engagement invitation.
    /// Acceptable values are `AWS` or `Sandbox`, and these values determine the
    /// environment in which the opportunity is managed.
    catalog: []const u8,

    /// This is the unique identifier of the rejected `EngagementInvitation`.
    /// Providing the correct identifier helps to ensure that the intended
    /// invitation is rejected.
    identifier: []const u8,

    /// This describes the reason for rejecting the engagement invitation, which
    /// helps AWS track usage patterns. Acceptable values include the following:
    ///
    /// * *Customer problem unclear:* The customer's problem isn't understood.
    /// * *Next steps unclear:* The next steps required to proceed aren't
    ///   understood.
    /// * *Unable to support:* The partner is unable to provide support due to
    ///   resource or capability constraints.
    /// * *Duplicate of partner referral:* The opportunity is a duplicate of an
    ///   existing referral.
    /// * *Other:* Any reason not covered by other values.
    rejection_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
        .rejection_reason = "RejectionReason",
    };
};

pub const RejectEngagementInvitationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RejectEngagementInvitationInput, options: CallOptions) !RejectEngagementInvitationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RejectEngagementInvitationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.RejectEngagementInvitation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RejectEngagementInvitationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
