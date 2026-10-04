const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SelfManagedCaseStatus = @import("self_managed_case_status.zig").SelfManagedCaseStatus;

pub const UpdateCaseStatusInput = struct {
    /// Required element for UpdateCaseStatus to identify the case to update.
    case_id: []const u8,

    /// Required element for UpdateCaseStatus to identify the status for a case.
    /// Options include `Submitted | Detection and Analysis | Containment,
    /// Eradication and Recovery | Post-incident Activities`.
    case_status: SelfManagedCaseStatus,

    pub const json_field_names = .{
        .case_id = "caseId",
        .case_status = "caseStatus",
    };
};

pub const UpdateCaseStatusOutput = struct {
    /// Response element for UpdateCaseStatus showing the newly configured status.
    case_status: ?SelfManagedCaseStatus = null,

    pub const json_field_names = .{
        .case_status = "caseStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCaseStatusInput, options: CallOptions) !UpdateCaseStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCaseStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/update-case-status");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"caseStatus\":");
    try aws.json.writeValue(@TypeOf(input.case_status), input.case_status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCaseStatusOutput {
    var result: UpdateCaseStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCaseStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
