const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const TransferDomainToAnotherAwsAccountInput = struct {
    /// The account ID of the Amazon Web Services account that you want to transfer
    /// the domain
    /// to, for example, `111122223333`.
    account_id: []const u8,

    /// The name of the domain that you want to transfer from the current Amazon Web
    /// Services account to another account.
    domain_name: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .domain_name = "DomainName",
    };
};

pub const TransferDomainToAnotherAwsAccountOutput = struct {
    /// Identifier for tracking the progress of the request. To query the operation
    /// status,
    /// use
    /// [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html).
    operation_id: ?[]const u8 = null,

    /// To finish transferring a domain to another Amazon Web Services account, the
    /// account
    /// that the domain is being transferred to must submit an
    /// [AcceptDomainTransferFromAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_AcceptDomainTransferFromAnotherAwsAccount.html) request. The request must include
    /// the value of the `Password` element that was returned in the
    /// `TransferDomainToAnotherAwsAccount` response.
    password: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
        .password = "Password",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TransferDomainToAnotherAwsAccountInput, options: CallOptions) !TransferDomainToAnotherAwsAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53domains", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TransferDomainToAnotherAwsAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.TransferDomainToAnotherAwsAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TransferDomainToAnotherAwsAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TransferDomainToAnotherAwsAccountOutput, body, allocator);
}
