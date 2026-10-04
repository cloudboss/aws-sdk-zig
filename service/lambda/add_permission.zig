const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionUrlAuthType = @import("function_url_auth_type.zig").FunctionUrlAuthType;

pub const AddPermissionInput = struct {
    /// The action that the principal can use on the function. For example,
    /// `lambda:InvokeFunction` or `lambda:GetFunction`.
    action: []const u8,

    /// For Alexa Smart Home functions, a token that the invoker must supply.
    event_source_token: ?[]const u8 = null,

    /// The name or ARN of the Lambda function, version, or alias. **Name formats**
    ///
    /// * **Function name** – `my-function` (name-only), `my-function:v1` (with
    ///   alias).
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// You can append a version number or alias to any of the formats. The length
    /// constraint applies only to the full ARN. If you specify only the function
    /// name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// The type of authentication that your function URL uses. Set to `AWS_IAM` if
    /// you want to restrict access to authenticated users only. Set to `NONE` if
    /// you want to bypass IAM authentication to create a public endpoint. For more
    /// information, see [Control access to Lambda function
    /// URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html).
    function_url_auth_type: ?FunctionUrlAuthType = null,

    /// Indicates whether the permission applies when the function is invoked
    /// through a function URL.
    invoked_via_function_url: ?bool = null,

    /// The Amazon Web Services service, Amazon Web Services account, IAM user, or
    /// IAM role that invokes the function. If you specify a service, use
    /// `SourceArn` or `SourceAccount` to limit who can invoke the function through
    /// that service.
    principal: []const u8,

    /// The identifier for your organization in Organizations. Use this to grant
    /// permissions to all the Amazon Web Services accounts under this organization.
    principal_org_id: ?[]const u8 = null,

    /// Specify a version or alias to add permissions to a published version of the
    /// function.
    qualifier: ?[]const u8 = null,

    /// Update the policy only if the revision ID matches the ID that's specified.
    /// Use this option to avoid modifying a policy that has changed since you last
    /// read it.
    revision_id: ?[]const u8 = null,

    /// For Amazon Web Services service, the ID of the Amazon Web Services account
    /// that owns the resource. Use this together with `SourceArn` to ensure that
    /// the specified account owns the resource. It is possible for an Amazon S3
    /// bucket to be deleted by its owner and recreated by another account.
    source_account: ?[]const u8 = null,

    /// For Amazon Web Services services, the ARN of the Amazon Web Services
    /// resource that invokes the function. For example, an Amazon S3 bucket or
    /// Amazon SNS topic.
    ///
    /// Note that Lambda configures the comparison using the `StringLike` operator.
    source_arn: ?[]const u8 = null,

    /// A statement identifier that differentiates the statement from others in the
    /// same policy.
    statement_id: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .event_source_token = "EventSourceToken",
        .function_name = "FunctionName",
        .function_url_auth_type = "FunctionUrlAuthType",
        .invoked_via_function_url = "InvokedViaFunctionUrl",
        .principal = "Principal",
        .principal_org_id = "PrincipalOrgID",
        .qualifier = "Qualifier",
        .revision_id = "RevisionId",
        .source_account = "SourceAccount",
        .source_arn = "SourceArn",
        .statement_id = "StatementId",
    };
};

pub const AddPermissionOutput = struct {
    /// The permission statement that's added to the function policy.
    statement: ?[]const u8 = null,

    pub const json_field_names = .{
        .statement = "Statement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddPermissionInput, options: CallOptions) !AddPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.event_source_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EventSourceToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.function_url_auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FunctionUrlAuthType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.invoked_via_function_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InvokedViaFunctionUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
    has_prev = true;
    if (input.principal_org_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrincipalOrgID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_account) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceAccount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StatementId\":");
    try aws.json.writeValue(@TypeOf(input.statement_id), input.statement_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddPermissionOutput {
    const result: AddPermissionOutput = try aws.json.parseJsonObject(
        AddPermissionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
