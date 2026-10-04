const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaxRegistration = @import("tax_registration.zig").TaxRegistration;

pub const GetTaxRegistrationInput = struct {
    /// Your unique account identifier.
    account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};

pub const GetTaxRegistrationOutput = struct {
    /// TRN information of the account mentioned in the request.
    tax_registration: ?TaxRegistration = null,

    pub const json_field_names = .{
        .tax_registration = "taxRegistration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTaxRegistrationInput, options: CallOptions) !GetTaxRegistrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTaxRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tax", "TaxSettings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetTaxRegistration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTaxRegistrationOutput {
    var result: GetTaxRegistrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTaxRegistrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
