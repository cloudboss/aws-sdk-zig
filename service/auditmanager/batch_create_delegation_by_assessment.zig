const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateDelegationRequest = @import("create_delegation_request.zig").CreateDelegationRequest;
const Delegation = @import("delegation.zig").Delegation;
const BatchCreateDelegationByAssessmentError = @import("batch_create_delegation_by_assessment_error.zig").BatchCreateDelegationByAssessmentError;

pub const BatchCreateDelegationByAssessmentInput = struct {
    /// The identifier for the assessment.
    assessment_id: []const u8,

    /// The API request to batch create delegations in Audit Manager.
    create_delegation_requests: []const CreateDelegationRequest,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .create_delegation_requests = "createDelegationRequests",
    };
};

pub const BatchCreateDelegationByAssessmentOutput = struct {
    /// The delegations that are associated with the assessment.
    delegations: ?[]const Delegation = null,

    /// A list of errors that the `BatchCreateDelegationByAssessment` API returned.
    errors: ?[]const BatchCreateDelegationByAssessmentError = null,

    pub const json_field_names = .{
        .delegations = "delegations",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateDelegationByAssessmentInput, options: CallOptions) !BatchCreateDelegationByAssessmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateDelegationByAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assessments/");
    try path_buf.appendSlice(allocator, input.assessment_id);
    try path_buf.appendSlice(allocator, "/delegations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"createDelegationRequests\":");
    try aws.json.writeValue(@TypeOf(input.create_delegation_requests), input.create_delegation_requests, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateDelegationByAssessmentOutput {
    const result: BatchCreateDelegationByAssessmentOutput = try aws.json.parseJsonObject(
        BatchCreateDelegationByAssessmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
