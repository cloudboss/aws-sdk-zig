const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Invitation = @import("invitation.zig").Invitation;

pub const CreateEngagementInvitationInput = struct {
    /// Specifies the catalog related to the engagement. Accepted values are `AWS`
    /// and `Sandbox`, which determine the environment in which the engagement is
    /// managed.
    catalog: []const u8,

    /// Specifies a unique, client-generated UUID to ensure that the request is
    /// handled exactly once. This token helps prevent duplicate invitation
    /// creations.
    client_token: []const u8,

    /// The unique identifier of the `Engagement` associated with the invitation.
    /// This parameter ensures the invitation is created within the correct
    /// `Engagement` context.
    engagement_identifier: []const u8,

    /// The `Invitation` object all information necessary to initiate an engagement
    /// invitation to a partner. It contains a personalized message from the sender,
    /// the invitation's receiver, and a payload. The `Payload` can be the
    /// `OpportunityInvitation`, which includes detailed structures for sender
    /// contacts, partner responsibilities, customer information, and project
    /// details, or `LeadInvitation`, which includes structures for customer
    /// information and interaction details.
    invitation: Invitation,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .engagement_identifier = "EngagementIdentifier",
        .invitation = "Invitation",
    };
};

pub const CreateEngagementInvitationOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the engagement
    /// invitation.
    arn: []const u8,

    /// Unique identifier assigned to the newly created engagement invitation.
    id: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEngagementInvitationInput, options: CallOptions) !CreateEngagementInvitationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEngagementInvitationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.CreateEngagementInvitation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEngagementInvitationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEngagementInvitationOutput, body, allocator);
}
