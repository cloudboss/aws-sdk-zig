const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelLegalHoldInput = struct {
    /// A string the describes the reason for removing the legal hold.
    cancel_description: []const u8,

    /// The ID of the legal hold.
    legal_hold_id: []const u8,

    /// The integer amount, in days, after which to remove legal hold.
    retain_record_in_days: ?i64 = null,

    pub const json_field_names = .{
        .cancel_description = "CancelDescription",
        .legal_hold_id = "LegalHoldId",
        .retain_record_in_days = "RetainRecordInDays",
    };
};

pub const CancelLegalHoldOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelLegalHoldInput, options: CallOptions) !CancelLegalHoldOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelLegalHoldInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/legal-holds/");
    try path_buf.appendSlice(allocator, input.legal_hold_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "cancelDescription=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.cancel_description);
    query_has_prev = true;
    if (input.retain_record_in_days) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "retainRecordInDays=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelLegalHoldOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CancelLegalHoldOutput = .{};

    return result;
}
