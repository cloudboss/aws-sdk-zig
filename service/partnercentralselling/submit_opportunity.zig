const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SalesInvolvementType = @import("sales_involvement_type.zig").SalesInvolvementType;
const Visibility = @import("visibility.zig").Visibility;

pub const SubmitOpportunityInput = struct {
    /// Specifies the catalog related to the request. Valid values are:
    ///
    /// * AWS: Submits the opportunity request from the production AWS environment.
    /// * Sandbox: Submits the opportunity request from a sandbox environment used
    ///   for testing or development purposes.
    catalog: []const u8,

    /// The identifier of the Opportunity previously created by partner and needs to
    /// be submitted.
    identifier: []const u8,

    /// Specifies the level of AWS sellers' involvement on the opportunity. Valid
    /// values:
    ///
    /// * `Co-sell`: Indicates the user wants to co-sell with AWS. Share the
    ///   opportunity with AWS to receive deal assistance and support.
    /// * `For Visibility Only`: Indicates that the user does not need support from
    ///   AWS Sales Rep. Share this opportunity with AWS for visibility only, you
    ///   will not receive deal assistance and support.
    involvement_type: SalesInvolvementType,

    /// Determines whether to restrict visibility of the opportunity from AWS sales.
    /// Default value is Full. Valid values:
    ///
    /// * `Full`: The opportunity is fully visible to AWS sales.
    /// * `Limited`: The opportunity has restricted visibility to AWS sales.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
        .involvement_type = "InvolvementType",
        .visibility = "Visibility",
    };
};

pub const SubmitOpportunityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitOpportunityInput, options: CallOptions) !SubmitOpportunityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SubmitOpportunityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.SubmitOpportunity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SubmitOpportunityOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
