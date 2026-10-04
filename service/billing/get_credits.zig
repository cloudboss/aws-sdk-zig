const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreditData = @import("credit_data.zig").CreditData;

pub const GetCreditsInput = struct {
    /// The Amazon Web Services account ID. Must be a 12-digit numeric string.
    account_id: []const u8,

    /// The end date for the credit period as Unix epoch seconds. Must not be a
    /// future date and must be on or after `startDate`. Defaults to the current
    /// date when omitted.
    end_date: ?i64 = null,

    /// When `true` and the caller is the management account, the response
    /// aggregates credits across the entire consolidated billing family. When
    /// `false` or omitted, returns only credits for the specified `accountId`.
    payer_account_flag: ?bool = null,

    /// The start date for the credit period as Unix epoch seconds. Must be a past
    /// date that is not more than one year before the current date.
    start_date: i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .end_date = "endDate",
        .payer_account_flag = "payerAccountFlag",
        .start_date = "startDate",
    };
};

pub const GetCreditsOutput = struct {
    /// The list of credits matching the request. Returns an empty list when no
    /// credits exist.
    credits: ?[]const CreditData = null,

    pub const json_field_names = .{
        .credits = "credits",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCreditsInput, options: CallOptions) !GetCreditsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCreditsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billing", "Billing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.GetCredits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCreditsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCreditsOutput, body, allocator);
}
