const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssigneeContact = @import("assignee_contact.zig").AssigneeContact;

pub const AssignOpportunityInput = struct {
    /// Specifies the user or team member responsible for managing the assigned
    /// opportunity. This field identifies the *Assignee* based on the partner's
    /// internal team structure. Ensure that the email address is associated with a
    /// registered user in your Partner Central account.
    assignee: AssigneeContact,

    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunity is assigned in. Use `AWS` to assign real
    /// opportunities in the Amazon Web Services catalog, and `Sandbox` for testing
    /// in secure, isolated environments.
    catalog: []const u8,

    /// Requires the `Opportunity`'s unique identifier when you want to assign it to
    /// another user. Provide the correct identifier so the intended opportunity is
    /// reassigned.
    identifier: []const u8,

    pub const json_field_names = .{
        .assignee = "Assignee",
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const AssignOpportunityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssignOpportunityInput, options: CallOptions) !AssignOpportunityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssignOpportunityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.AssignOpportunity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssignOpportunityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
