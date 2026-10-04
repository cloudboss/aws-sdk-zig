const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteTaxRegistrationError = @import("batch_delete_tax_registration_error.zig").BatchDeleteTaxRegistrationError;

pub const BatchDeleteTaxRegistrationInput = struct {
    /// List of unique account identifiers.
    account_ids: []const []const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
    };
};

pub const BatchDeleteTaxRegistrationOutput = struct {
    /// The list of errors for the accounts the TRN information could not be deleted
    /// for.
    errors: ?[]const BatchDeleteTaxRegistrationError = null,

    pub const json_field_names = .{
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteTaxRegistrationInput, options: CallOptions) !BatchDeleteTaxRegistrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteTaxRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tax", "TaxSettings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchDeleteTaxRegistration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteTaxRegistrationOutput {
    var result: BatchDeleteTaxRegistrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDeleteTaxRegistrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
