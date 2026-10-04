const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelatedEntityType = @import("related_entity_type.zig").RelatedEntityType;

pub const AssociateOpportunityInput = struct {
    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunity association is made in. Use `AWS` to
    /// associate opportunities in the Amazon Web Services catalog, and `Sandbox`
    /// for testing in secure, isolated environments.
    catalog: []const u8,

    /// Requires the `Opportunity`'s unique identifier when you want to associate it
    /// with a related entity. Provide the correct identifier so the intended
    /// opportunity is updated with the association.
    opportunity_identifier: []const u8,

    /// Requires the related entity's unique identifier when you want to associate
    /// it with the ` Opportunity`. For Amazon Web Services Marketplace entities,
    /// provide the Amazon Resource Name (ARN). Use the [ Amazon Web Services
    /// Marketplace
    /// API](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html) to obtain the ARN.
    related_entity_identifier: []const u8,

    /// Specifies the entity type that you're associating with the ` Opportunity`.
    /// This helps to categorize and properly process the association.
    related_entity_type: RelatedEntityType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .opportunity_identifier = "OpportunityIdentifier",
        .related_entity_identifier = "RelatedEntityIdentifier",
        .related_entity_type = "RelatedEntityType",
    };
};

pub const AssociateOpportunityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateOpportunityInput, options: CallOptions) !AssociateOpportunityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateOpportunityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.AssociateOpportunity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateOpportunityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
