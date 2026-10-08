const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const ContinueUpdateRollbackInput = struct {
    /// A unique identifier for this `ContinueUpdateRollback` request. Specify this
    /// token if you plan to retry requests so that CloudFormation knows that you're
    /// not attempting to
    /// continue the rollback to a stack with the same name. You might retry
    /// `ContinueUpdateRollback` requests to ensure that CloudFormation successfully
    /// received
    /// them.
    client_request_token: ?[]const u8 = null,

    /// A list of the logical IDs of the resources that CloudFormation skips during
    /// the continue
    /// update rollback operation. You can specify only resources that are in the
    /// `UPDATE_FAILED` state because a rollback failed. You can't specify resources
    /// that
    /// are in the `UPDATE_FAILED` state for other reasons, for example, because an
    /// update
    /// was canceled. To check why a resource update failed, use the
    /// DescribeStackResources action, and view the resource status reason.
    ///
    /// Specify this property to skip rolling back resources that CloudFormation
    /// can't successfully
    /// roll back. We recommend that you [
    /// troubleshoot](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-update-rollback-failed) resources before skipping them. CloudFormation sets the status of the
    /// specified resources to `UPDATE_COMPLETE` and continues to roll back the
    /// stack.
    /// After the rollback is complete, the state of the skipped resources will be
    /// inconsistent with
    /// the state of the resources in the stack template. Before performing another
    /// stack update,
    /// you must update the stack or resources to be consistent with each other. If
    /// you don't,
    /// subsequent stack updates might fail, and the stack will become
    /// unrecoverable.
    ///
    /// Specify the minimum number of resources required to successfully roll back
    /// your stack. For
    /// example, a failed resource update might cause dependent resources to fail.
    /// In this case, it
    /// might not be necessary to skip the dependent resources.
    ///
    /// To skip resources that are part of nested stacks, use the following format:
    /// `NestedStackName.ResourceLogicalID`. If you want to specify the logical ID
    /// of a
    /// stack resource (`Type: AWS::CloudFormation::Stack`) in the
    /// `ResourcesToSkip` list, then its corresponding embedded stack must be in one
    /// of
    /// the following states: `DELETE_IN_PROGRESS`, `DELETE_COMPLETE`, or
    /// `DELETE_FAILED`.
    ///
    /// Don't confuse a child stack's name with its corresponding logical ID defined
    /// in the
    /// parent stack. For an example of a continue update rollback operation with
    /// nested stacks, see
    /// [Continue rolling back from failed nested stack
    /// updates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-continueupdaterollback.html#nested-stacks).
    resources_to_skip: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that CloudFormation assumes to
    /// roll back the
    /// stack. CloudFormation uses the role's credentials to make calls on your
    /// behalf. CloudFormation always
    /// uses this role for all future operations on the stack. Provided that users
    /// have permission to
    /// operate on the stack, CloudFormation uses this role even if the users don't
    /// have permission to
    /// pass it. Ensure that the role grants least permission.
    ///
    /// If you don't specify a value, CloudFormation uses the role that was
    /// previously associated with
    /// the stack. If no role is available, CloudFormation uses a temporary session
    /// that's generated from
    /// your user credentials.
    role_arn: ?[]const u8 = null,

    /// The name or the unique ID of the stack that you want to continue rolling
    /// back.
    ///
    /// Don't specify the name of a nested stack (a stack that was created by using
    /// the
    /// `AWS::CloudFormation::Stack` resource). Instead, use this operation on the
    /// parent stack (the stack that contains the `AWS::CloudFormation::Stack`
    /// resource).
    stack_name: []const u8,
};

pub const ContinueUpdateRollbackOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ContinueUpdateRollbackInput, options: CallOptions) !ContinueUpdateRollbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ContinueUpdateRollbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ContinueUpdateRollback&Version=2010-05-15");
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.resources_to_skip) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourcesToSkip.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.role_arn) |v| {
        try body_buf.appendSlice(allocator, "&RoleARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ContinueUpdateRollbackOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ContinueUpdateRollbackOutput = .{};

    return result;
}
