const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IAMPolicyAssignment = @import("iam_policy_assignment.zig").IAMPolicyAssignment;

pub const DescribeIAMPolicyAssignmentInput = struct {
    /// The name of the assignment, also called a rule.
    assignment_name: []const u8,

    /// The ID of the Amazon Web Services account that contains the assignment that
    /// you want to
    /// describe.
    aws_account_id: []const u8,

    /// The namespace that contains the assignment.
    namespace: []const u8,

    pub const json_field_names = .{
        .assignment_name = "AssignmentName",
        .aws_account_id = "AwsAccountId",
        .namespace = "Namespace",
    };
};

pub const DescribeIAMPolicyAssignmentOutput = struct {
    /// Information describing the IAM policy assignment.
    iam_policy_assignment: ?IAMPolicyAssignment = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .iam_policy_assignment = "IAMPolicyAssignment",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIAMPolicyAssignmentInput, options: CallOptions) !DescribeIAMPolicyAssignmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIAMPolicyAssignmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/iam-policy-assignments/");
    try path_buf.appendSlice(allocator, input.assignment_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIAMPolicyAssignmentOutput {
    var result: DescribeIAMPolicyAssignmentOutput = try aws.json.parseJsonObject(
        DescribeIAMPolicyAssignmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
