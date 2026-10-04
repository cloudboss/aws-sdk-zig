const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecyclePolicyDetail = @import("lifecycle_policy_detail.zig").LifecyclePolicyDetail;
const LifecyclePolicyResourceSelection = @import("lifecycle_policy_resource_selection.zig").LifecyclePolicyResourceSelection;
const LifecyclePolicyResourceType = @import("lifecycle_policy_resource_type.zig").LifecyclePolicyResourceType;
const LifecyclePolicyStatus = @import("lifecycle_policy_status.zig").LifecyclePolicyStatus;

pub const CreateLifecyclePolicyInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// Optional description for the lifecycle policy.
    description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) for the IAM role you create that
    /// grants
    /// Image Builder access to run lifecycle actions.
    execution_role: []const u8,

    /// The name of the lifecycle policy to create.
    name: []const u8,

    /// Configuration details for the lifecycle policy rules.
    policy_details: []const LifecyclePolicyDetail,

    /// Selection criteria for the resources that the lifecycle policy applies to.
    resource_selection: LifecyclePolicyResourceSelection,

    /// The type of Image Builder resource that the lifecycle policy applies to.
    resource_type: LifecyclePolicyResourceType,

    /// Indicates whether the lifecycle policy resource is enabled.
    status: ?LifecyclePolicyStatus = null,

    /// Tags to apply to the lifecycle policy resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .execution_role = "executionRole",
        .name = "name",
        .policy_details = "policyDetails",
        .resource_selection = "resourceSelection",
        .resource_type = "resourceType",
        .status = "status",
        .tags = "tags",
    };
};

pub const CreateLifecyclePolicyOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the lifecycle policy that the request
    /// created.
    lifecycle_policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .lifecycle_policy_arn = "lifecyclePolicyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLifecyclePolicyInput, options: CallOptions) !CreateLifecyclePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLifecyclePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateLifecyclePolicy";

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
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLifecyclePolicyOutput {
    var result: CreateLifecyclePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLifecyclePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
