const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShareRequestAction = @import("share_request_action.zig").ShareRequestAction;
const ShareRequestType = @import("share_request_type.zig").ShareRequestType;
const AssessmentFrameworkShareRequest = @import("assessment_framework_share_request.zig").AssessmentFrameworkShareRequest;

pub const UpdateAssessmentFrameworkShareInput = struct {
    /// Specifies the update action for the share request.
    action: ShareRequestAction,

    /// The unique identifier for the share request.
    request_id: []const u8,

    /// Specifies whether the share request is a sent request or a received request.
    request_type: ShareRequestType,

    pub const json_field_names = .{
        .action = "action",
        .request_id = "requestId",
        .request_type = "requestType",
    };
};

pub const UpdateAssessmentFrameworkShareOutput = struct {
    /// The updated share request that's returned by the
    /// `UpdateAssessmentFrameworkShare` operation.
    assessment_framework_share_request: ?AssessmentFrameworkShareRequest = null,

    pub const json_field_names = .{
        .assessment_framework_share_request = "assessmentFrameworkShareRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssessmentFrameworkShareInput, options: CallOptions) !UpdateAssessmentFrameworkShareOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssessmentFrameworkShareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessmentFrameworkShareRequests/");
    try path_buf.appendSlice(allocator, input.request_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestType\":");
    try aws.json.writeValue(@TypeOf(input.request_type), input.request_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssessmentFrameworkShareOutput {
    var result: UpdateAssessmentFrameworkShareOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAssessmentFrameworkShareOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
