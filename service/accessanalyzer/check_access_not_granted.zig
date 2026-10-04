const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Access = @import("access.zig").Access;
const AccessCheckPolicyType = @import("access_check_policy_type.zig").AccessCheckPolicyType;
const ReasonSummary = @import("reason_summary.zig").ReasonSummary;
const CheckAccessNotGrantedResult = @import("check_access_not_granted_result.zig").CheckAccessNotGrantedResult;

pub const CheckAccessNotGrantedInput = struct {
    /// An access object containing the permissions that shouldn't be granted by the
    /// specified policy. If only actions are specified, IAM Access Analyzer checks
    /// for access to peform at least one of the actions on any resource in the
    /// policy. If only resources are specified, then IAM Access Analyzer checks for
    /// access to perform any action on at least one of the resources. If both
    /// actions and resources are specified, IAM Access Analyzer checks for access
    /// to perform at least one of the specified actions on at least one of the
    /// specified resources.
    access: []const Access,

    /// The JSON policy document to use as the content for the policy.
    policy_document: []const u8,

    /// The type of policy. Identity policies grant permissions to IAM principals.
    /// Identity policies include managed and inline policies for IAM roles, users,
    /// and groups.
    ///
    /// Resource policies grant permissions on Amazon Web Services resources.
    /// Resource policies include trust policies for IAM roles and bucket policies
    /// for Amazon S3 buckets.
    policy_type: AccessCheckPolicyType,

    pub const json_field_names = .{
        .access = "access",
        .policy_document = "policyDocument",
        .policy_type = "policyType",
    };
};

pub const CheckAccessNotGrantedOutput = struct {
    /// The message indicating whether the specified access is allowed.
    message: ?[]const u8 = null,

    /// A description of the reasoning of the result.
    reasons: ?[]const ReasonSummary = null,

    /// The result of the check for whether the access is allowed. If the result is
    /// `PASS`, the specified policy doesn't allow any of the specified permissions
    /// in the access object. If the result is `FAIL`, the specified policy might
    /// allow some or all of the permissions in the access object.
    result: ?CheckAccessNotGrantedResult = null,

    pub const json_field_names = .{
        .message = "message",
        .reasons = "reasons",
        .result = "result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckAccessNotGrantedInput, options: CallOptions) !CheckAccessNotGrantedOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckAccessNotGrantedInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policy/check-access-not-granted";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"access\":");
    try aws.json.writeValue(@TypeOf(input.access), input.access, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyType\":");
    try aws.json.writeValue(@TypeOf(input.policy_type), input.policy_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckAccessNotGrantedOutput {
    var result: CheckAccessNotGrantedOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CheckAccessNotGrantedOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
