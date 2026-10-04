const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribedAgreement = @import("described_agreement.zig").DescribedAgreement;

pub const DescribeAgreementInput = struct {
    /// A unique identifier for the agreement. This identifier is returned when you
    /// create an agreement.
    agreement_id: []const u8,

    /// The server identifier that's associated with the agreement.
    server_id: []const u8,

    pub const json_field_names = .{
        .agreement_id = "AgreementId",
        .server_id = "ServerId",
    };
};

pub const DescribeAgreementOutput = struct {
    /// The details for the specified agreement, returned as a `DescribedAgreement`
    /// object.
    agreement: ?DescribedAgreement = null,

    pub const json_field_names = .{
        .agreement = "Agreement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAgreementInput, options: CallOptions) !DescribeAgreementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAgreementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.DescribeAgreement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAgreementOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAgreementOutput, body, allocator);
}
