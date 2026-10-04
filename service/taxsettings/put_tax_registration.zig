const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaxRegistrationEntry = @import("tax_registration_entry.zig").TaxRegistrationEntry;
const TaxRegistrationStatus = @import("tax_registration_status.zig").TaxRegistrationStatus;

pub const PutTaxRegistrationInput = struct {
    /// Your unique account identifier.
    account_id: ?[]const u8 = null,

    /// Your TRN information that will be stored to the account mentioned in
    /// `accountId`.
    tax_registration_entry: TaxRegistrationEntry,

    pub const json_field_names = .{
        .account_id = "accountId",
        .tax_registration_entry = "taxRegistrationEntry",
    };
};

pub const PutTaxRegistrationOutput = struct {
    /// The status of your TRN stored in the system after processing. Based on the
    /// validation occurring on the TRN, the status can be `Verified`, `Pending` or
    /// `Rejected`.
    status: ?TaxRegistrationStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutTaxRegistrationInput, options: CallOptions) !PutTaxRegistrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutTaxRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tax", "TaxSettings", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutTaxRegistration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"taxRegistrationEntry\":");
    try aws.json.writeValue(@TypeOf(input.tax_registration_entry), input.tax_registration_entry, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutTaxRegistrationOutput {
    const result: PutTaxRegistrationOutput = try aws.json.parseJsonObject(
        PutTaxRegistrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
