const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExecuteChangeSetInput = struct {
    /// The name or Amazon Resource Name (ARN) of the change set that you want use
    /// to update the
    /// specified stack.
    change_set_name: []const u8,

    /// A unique identifier for this `ExecuteChangeSet` request. Specify this token
    /// if
    /// you plan to retry requests so that CloudFormation knows that you're not
    /// attempting to execute a
    /// change set to update a stack with the same name. You might retry
    /// `ExecuteChangeSet`
    /// requests to ensure that CloudFormation successfully received them.
    client_request_token: ?[]const u8 = null,

    /// Preserves the state of previously provisioned resources when an operation
    /// fails. This
    /// parameter can't be specified when the `OnStackFailure` parameter to the
    /// [CreateChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateChangeSet.html) API operation was specified.
    ///
    /// * `True` - if the stack creation fails, do nothing. This is equivalent to
    /// specifying `DO_NOTHING` for the `OnStackFailure` parameter to the
    /// [CreateChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateChangeSet.html) API operation.
    ///
    /// * `False` - if the stack creation fails, roll back the stack. This is
    /// equivalent to specifying `ROLLBACK` for the `OnStackFailure`
    /// parameter to the
    /// [CreateChangeSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateChangeSet.html) API operation.
    ///
    /// Default: `True`
    disable_rollback: ?bool = null,

    /// When set to `true`, newly created resources are deleted when the operation
    /// rolls back. This includes newly created resources marked with a deletion
    /// policy of
    /// `Retain`.
    ///
    /// Default: `false`
    retain_except_on_create: ?bool = null,

    /// If you specified the name of a change set, specify the stack name or Amazon
    /// Resource Name
    /// (ARN) that's associated with the change set you want to execute.
    stack_name: ?[]const u8 = null,
};

pub const ExecuteChangeSetOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteChangeSetInput, options: CallOptions) !ExecuteChangeSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ExecuteChangeSet&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&ChangeSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.change_set_name);
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.disable_rollback) |v| {
        try body_buf.appendSlice(allocator, "&DisableRollback=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.retain_except_on_create) |v| {
        try body_buf.appendSlice(allocator, "&RetainExceptOnCreate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.stack_name) |v| {
        try body_buf.appendSlice(allocator, "&StackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteChangeSetOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ExecuteChangeSetOutput = .{};

    return result;
}
