const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaseStatus = @import("case_status.zig").CaseStatus;

pub const CloseCaseInput = struct {
    /// Required element used in combination with CloseCase to identify the case ID
    /// to close.
    case_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub const CloseCaseOutput = struct {
    /// A response element providing responses for requests to CloseCase. This
    /// element responds `Closed ` if successful.
    case_status: ?CaseStatus = null,

    /// A response element providing responses for requests to CloseCase. This
    /// element responds with the ISO-8601 formatted timestamp of the moment when
    /// the case was closed.
    closed_date: ?i64 = null,

    pub const json_field_names = .{
        .case_status = "caseStatus",
        .closed_date = "closedDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CloseCaseInput, options: CallOptions) !CloseCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CloseCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/close-case");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CloseCaseOutput {
    var result: CloseCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CloseCaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
