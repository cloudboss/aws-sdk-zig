const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessCheckResourceType = @import("access_check_resource_type.zig").AccessCheckResourceType;
const ReasonSummary = @import("reason_summary.zig").ReasonSummary;
const CheckNoPublicAccessResult = @import("check_no_public_access_result.zig").CheckNoPublicAccessResult;

pub const CheckNoPublicAccessInput = struct {
    /// The JSON policy document to evaluate for public access.
    policy_document: []const u8,

    /// The type of resource to evaluate for public access. For example, to check
    /// for public access to Amazon S3 buckets, you can choose `AWS::S3::Bucket` for
    /// the resource type.
    ///
    /// For resource types not supported as valid values, IAM Access Analyzer will
    /// return an error.
    resource_type: AccessCheckResourceType,

    pub const json_field_names = .{
        .policy_document = "policyDocument",
        .resource_type = "resourceType",
    };
};

pub const CheckNoPublicAccessOutput = struct {
    /// The message indicating whether the specified policy allows public access to
    /// resources.
    message: ?[]const u8 = null,

    /// A list of reasons why the specified resource policy grants public access for
    /// the resource type.
    reasons: ?[]const ReasonSummary = null,

    /// The result of the check for public access to the specified resource type. If
    /// the result is `PASS`, the policy doesn't allow public access to the
    /// specified resource type. If the result is `FAIL`, the policy might allow
    /// public access to the specified resource type.
    result: ?CheckNoPublicAccessResult = null,

    pub const json_field_names = .{
        .message = "message",
        .reasons = "reasons",
        .result = "result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckNoPublicAccessInput, options: CallOptions) !CheckNoPublicAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckNoPublicAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policy/check-no-public-access";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckNoPublicAccessOutput {
    var result: CheckNoPublicAccessOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CheckNoPublicAccessOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
