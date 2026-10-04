const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssignmentStatus = @import("assignment_status.zig").AssignmentStatus;

pub const UpdateIAMPolicyAssignmentInput = struct {
    /// The name of the assignment, also called a rule.
    /// The
    /// name must be unique within the
    /// Amazon Web Services account.
    assignment_name: []const u8,

    /// The status of the assignment. Possible values are as follows:
    ///
    /// * `ENABLED` - Anything specified in this assignment is used when
    /// creating the data source.
    ///
    /// * `DISABLED` - This assignment isn't used when creating the data
    /// source.
    ///
    /// * `DRAFT` - This assignment is an unfinished draft and isn't used
    /// when creating the data source.
    assignment_status: ?AssignmentStatus = null,

    /// The ID of the Amazon Web Services account that contains the IAM policy
    /// assignment.
    aws_account_id: []const u8,

    /// The Amazon Quick Sight users, groups, or both that you want to assign the
    /// policy
    /// to.
    identities: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The namespace of the assignment.
    namespace: []const u8,

    /// The ARN for the IAM policy to apply to the Amazon Quick Sight users and
    /// groups specified in this assignment.
    policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_name = "AssignmentName",
        .assignment_status = "AssignmentStatus",
        .aws_account_id = "AwsAccountId",
        .identities = "Identities",
        .namespace = "Namespace",
        .policy_arn = "PolicyArn",
    };
};

pub const UpdateIAMPolicyAssignmentOutput = struct {
    /// The ID of the assignment.
    assignment_id: ?[]const u8 = null,

    /// The name of the assignment or rule.
    assignment_name: ?[]const u8 = null,

    /// The status of the assignment. Possible values are as follows:
    ///
    /// * `ENABLED` - Anything specified in this assignment is used when
    /// creating the data source.
    ///
    /// * `DISABLED` - This assignment isn't used when creating the data
    /// source.
    ///
    /// * `DRAFT` - This assignment is an unfinished draft and isn't used
    /// when creating the data source.
    assignment_status: ?AssignmentStatus = null,

    /// The Amazon Quick Sight users, groups, or both that the IAM policy is
    /// assigned to.
    identities: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The ARN for the IAM policy applied to the Amazon Quick Sight users and
    /// groups specified in this assignment.
    policy_arn: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .assignment_name = "AssignmentName",
        .assignment_status = "AssignmentStatus",
        .identities = "Identities",
        .policy_arn = "PolicyArn",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIAMPolicyAssignmentInput, options: CallOptions) !UpdateIAMPolicyAssignmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIAMPolicyAssignmentInput, config: *aws.Config) !aws.http.Request {
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.assignment_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssignmentStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Identities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIAMPolicyAssignmentOutput {
    var result: UpdateIAMPolicyAssignmentOutput = try aws.json.parseJsonObject(
        UpdateIAMPolicyAssignmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
