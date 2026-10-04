const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecyclePolicyDetail = @import("lifecycle_policy_detail.zig").LifecyclePolicyDetail;
const LifecyclePolicyResourceSelection = @import("lifecycle_policy_resource_selection.zig").LifecyclePolicyResourceSelection;
const LifecyclePolicyResourceType = @import("lifecycle_policy_resource_type.zig").LifecyclePolicyResourceType;
const LifecyclePolicyStatus = @import("lifecycle_policy_status.zig").LifecyclePolicyStatus;

pub const UpdateLifecyclePolicyInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// Optional description for the lifecycle policy. Because the update replaces
    /// the
    /// entire configuration, omitting this property removes any existing
    /// description.
    description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants Image Builder access
    /// to run lifecycle actions.
    execution_role: []const u8,

    /// The Amazon Resource Name (ARN) of the lifecycle policy resource.
    lifecycle_policy_arn: []const u8,

    /// The configuration details for a lifecycle policy resource.
    policy_details: []const LifecyclePolicyDetail,

    /// Selection criteria for resources that the lifecycle policy applies to. You
    /// must specify exactly one selection criteria: either recipes or a tag map,
    /// not both.
    resource_selection: LifecyclePolicyResourceSelection,

    /// The type of image resource that the lifecycle policy applies to. The value
    /// must match the policy's existing resource type. You can't change the
    /// resource type of an existing lifecycle policy.
    resource_type: LifecyclePolicyResourceType,

    /// Indicates whether the lifecycle policy resource is enabled. Defaults to
    /// `ENABLED` when omitted, so updating a disabled policy without
    /// setting this property re-enables it.
    status: ?LifecyclePolicyStatus = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .execution_role = "executionRole",
        .lifecycle_policy_arn = "lifecyclePolicyArn",
        .policy_details = "policyDetails",
        .resource_selection = "resourceSelection",
        .resource_type = "resourceType",
        .status = "status",
    };
};

pub const UpdateLifecyclePolicyOutput = struct {
    /// The Amazon Resource Name (ARN) of the image lifecycle policy resource that
    /// was updated.
    lifecycle_policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_policy_arn = "lifecyclePolicyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLifecyclePolicyInput, options: CallOptions) !UpdateLifecyclePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLifecyclePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateLifecyclePolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRole\":");
    try aws.json.writeValue(@TypeOf(input.execution_role), input.execution_role, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lifecyclePolicyArn\":");
    try aws.json.writeValue(@TypeOf(input.lifecycle_policy_arn), input.lifecycle_policy_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDetails\":");
    try aws.json.writeValue(@TypeOf(input.policy_details), input.policy_details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceSelection\":");
    try aws.json.writeValue(@TypeOf(input.resource_selection), input.resource_selection, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, allocator, &body_buf);
    has_prev = true;
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLifecyclePolicyOutput {
    const result: UpdateLifecyclePolicyOutput = try aws.json.parseJsonObject(
        UpdateLifecyclePolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
