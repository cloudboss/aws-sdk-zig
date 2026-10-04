const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedDiscoveryAccountUpdate = @import("automated_discovery_account_update.zig").AutomatedDiscoveryAccountUpdate;
const AutomatedDiscoveryAccountUpdateError = @import("automated_discovery_account_update_error.zig").AutomatedDiscoveryAccountUpdateError;

pub const BatchUpdateAutomatedDiscoveryAccountsInput = struct {
    /// An array of objects, one for each account to change the status of automated
    /// sensitive data discovery for. Each object specifies the Amazon Web Services
    /// account ID for an account and a new status for that account.
    accounts: ?[]const AutomatedDiscoveryAccountUpdate = null,

    pub const json_field_names = .{
        .accounts = "accounts",
    };
};

pub const BatchUpdateAutomatedDiscoveryAccountsOutput = struct {
    /// An array of objects, one for each account whose status wasn't changed. Each
    /// object identifies the account and explains why the status of automated
    /// sensitive data discovery wasn't changed for the account. This value is null
    /// if the request succeeded for all specified accounts.
    errors: ?[]const AutomatedDiscoveryAccountUpdateError = null,

    pub const json_field_names = .{
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateAutomatedDiscoveryAccountsInput, options: CallOptions) !BatchUpdateAutomatedDiscoveryAccountsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateAutomatedDiscoveryAccountsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automated-discovery/accounts";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accounts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accounts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateAutomatedDiscoveryAccountsOutput {
    var result: BatchUpdateAutomatedDiscoveryAccountsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateAutomatedDiscoveryAccountsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
