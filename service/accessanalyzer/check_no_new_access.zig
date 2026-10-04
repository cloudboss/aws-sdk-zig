const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessCheckPolicyType = @import("access_check_policy_type.zig").AccessCheckPolicyType;
const ReasonSummary = @import("reason_summary.zig").ReasonSummary;
const CheckNoNewAccessResult = @import("check_no_new_access_result.zig").CheckNoNewAccessResult;

pub const CheckNoNewAccessInput = struct {
    /// The JSON policy document to use as the content for the existing policy.
    existing_policy_document: []const u8,

    /// The JSON policy document to use as the content for the updated policy.
    new_policy_document: []const u8,

    /// The type of policy to compare. Identity policies grant permissions to IAM
    /// principals. Identity policies include managed and inline policies for IAM
    /// roles, users, and groups.
    ///
    /// Resource policies grant permissions on Amazon Web Services resources.
    /// Resource policies include trust policies for IAM roles and bucket policies
    /// for Amazon S3 buckets. You can provide a generic input such as identity
    /// policy or resource policy or a specific input such as managed policy or
    /// Amazon S3 bucket policy.
    policy_type: AccessCheckPolicyType,

    pub const json_field_names = .{
        .existing_policy_document = "existingPolicyDocument",
        .new_policy_document = "newPolicyDocument",
        .policy_type = "policyType",
    };
};

pub const CheckNoNewAccessOutput = struct {
    /// The message indicating whether the updated policy allows new access.
    message: ?[]const u8 = null,

    /// A description of the reasoning of the result.
    reasons: ?[]const ReasonSummary = null,

    /// The result of the check for new access. If the result is `PASS`, no new
    /// access is allowed by the updated policy. If the result is `FAIL`, the
    /// updated policy might allow new access.
    result: ?CheckNoNewAccessResult = null,

    pub const json_field_names = .{
        .message = "message",
        .reasons = "reasons",
        .result = "result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckNoNewAccessInput, options: CallOptions) !CheckNoNewAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckNoNewAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policy/check-no-new-access";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"existingPolicyDocument\":");
    try aws.json.writeValue(@TypeOf(input.existing_policy_document), input.existing_policy_document, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"newPolicyDocument\":");
    try aws.json.writeValue(@TypeOf(input.new_policy_document), input.new_policy_document, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckNoNewAccessOutput {
    const result: CheckNoNewAccessOutput = try aws.json.parseJsonObject(
        CheckNoNewAccessOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
