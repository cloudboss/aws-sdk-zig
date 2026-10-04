const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateCapabilityConfiguration = @import("update_capability_configuration.zig").UpdateCapabilityConfiguration;
const CapabilityDeletePropagationPolicy = @import("capability_delete_propagation_policy.zig").CapabilityDeletePropagationPolicy;
const Update = @import("update.zig").Update;

pub const UpdateCapabilityInput = struct {
    /// The name of the capability to update configuration for.
    capability_name: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This token is valid for 24 hours after creation.
    client_request_token: ?[]const u8 = null,

    /// The name of the Amazon EKS cluster that contains the capability you want to
    /// update configuration for.
    cluster_name: []const u8,

    /// The updated configuration settings for the capability. You only need to
    /// specify the configuration parameters you want to change. For Argo CD
    /// capabilities, you can update RBAC role mappings and network access settings.
    configuration: ?UpdateCapabilityConfiguration = null,

    /// The updated delete propagation policy for the capability. Currently, the
    /// only supported value is `RETAIN`.
    delete_propagation_policy: ?CapabilityDeletePropagationPolicy = null,

    /// The Amazon Resource Name (ARN) of the IAM role that the capability uses to
    /// interact with Amazon Web Services services. If you specify a new role ARN,
    /// the capability will start using the new role for all subsequent operations.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .capability_name = "capabilityName",
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .configuration = "configuration",
        .delete_propagation_policy = "deletePropagationPolicy",
        .role_arn = "roleArn",
    };
};

pub const UpdateCapabilityOutput = struct {
    update: ?Update = null,

    pub const json_field_names = .{
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCapabilityInput, options: CallOptions) !UpdateCapabilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCapabilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/capabilities/");
    try path_buf.appendSlice(allocator, input.capability_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.delete_propagation_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletePropagationPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCapabilityOutput {
    const result: UpdateCapabilityOutput = try aws.json.parseJsonObject(
        UpdateCapabilityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
