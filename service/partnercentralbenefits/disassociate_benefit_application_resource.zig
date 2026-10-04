const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateBenefitApplicationResourceInput = struct {
    /// The unique identifier of the benefit application to disassociate the
    /// resource from.
    benefit_application_identifier: []const u8,

    /// The catalog identifier that specifies which benefit catalog the application
    /// belongs to.
    catalog: []const u8,

    /// The Amazon Resource Name (ARN) of the AWS resource to disassociate from the
    /// benefit application.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .benefit_application_identifier = "BenefitApplicationIdentifier",
        .catalog = "Catalog",
        .resource_arn = "ResourceArn",
    };
};

pub const DisassociateBenefitApplicationResourceOutput = struct {
    /// The Amazon Resource Name (ARN) of the benefit application after the resource
    /// disassociation.
    arn: ?[]const u8 = null,

    /// The unique identifier of the benefit application after the resource
    /// disassociation.
    id: ?[]const u8 = null,

    /// The updated revision number of the benefit application after the resource
    /// disassociation.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .revision = "Revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateBenefitApplicationResourceInput, options: CallOptions) !DisassociateBenefitApplicationResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateBenefitApplicationResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-benefits", "PartnerCentral Benefits", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.DisassociateBenefitApplicationResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateBenefitApplicationResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateBenefitApplicationResourceOutput, body, allocator);
}
