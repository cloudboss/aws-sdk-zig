const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentFrameworkShareRequest = @import("assessment_framework_share_request.zig").AssessmentFrameworkShareRequest;

pub const StartAssessmentFrameworkShareInput = struct {
    /// An optional comment from the sender about the share request.
    comment: ?[]const u8 = null,

    /// The Amazon Web Services account of the recipient.
    destination_account: []const u8,

    /// The Amazon Web Services Region of the recipient.
    destination_region: []const u8,

    /// The unique identifier for the custom framework to be shared.
    framework_id: []const u8,

    pub const json_field_names = .{
        .comment = "comment",
        .destination_account = "destinationAccount",
        .destination_region = "destinationRegion",
        .framework_id = "frameworkId",
    };
};

pub const StartAssessmentFrameworkShareOutput = struct {
    /// The share request that's created by the `StartAssessmentFrameworkShare` API.
    assessment_framework_share_request: ?AssessmentFrameworkShareRequest = null,

    pub const json_field_names = .{
        .assessment_framework_share_request = "assessmentFrameworkShareRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAssessmentFrameworkShareInput, options: CallOptions) !StartAssessmentFrameworkShareOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAssessmentFrameworkShareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessmentFrameworks/");
    try path_buf.appendSlice(allocator, input.framework_id);
    try path_buf.appendSlice(allocator, "/shareRequests");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationAccount\":");
    try aws.json.writeValue(@TypeOf(input.destination_account), input.destination_account, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationRegion\":");
    try aws.json.writeValue(@TypeOf(input.destination_region), input.destination_region, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAssessmentFrameworkShareOutput {
    var result: StartAssessmentFrameworkShareOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAssessmentFrameworkShareOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
