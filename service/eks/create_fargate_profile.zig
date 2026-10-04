const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FargateProfileSelector = @import("fargate_profile_selector.zig").FargateProfileSelector;
const FargateProfile = @import("fargate_profile.zig").FargateProfile;

pub const CreateFargateProfileInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The name of the Fargate profile.
    fargate_profile_name: []const u8,

    /// The Amazon Resource Name (ARN) of the `Pod` execution role to use for a
    /// `Pod`
    /// that matches the selectors in the Fargate profile. The `Pod` execution role
    /// allows Fargate infrastructure to register with your cluster as a node, and
    /// it provides
    /// read access to Amazon ECR image repositories. For more information, see [
    /// `Pod` execution
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/pod-execution-role.html) in the *Amazon EKS User Guide*.
    pod_execution_role_arn: []const u8,

    /// The selectors to match for a `Pod` to use this Fargate profile. Each
    /// selector must have an associated Kubernetes `namespace`. Optionally, you can
    /// also
    /// specify `labels` for a `namespace`. You may specify up to five
    /// selectors in a Fargate profile.
    selectors: ?[]const FargateProfileSelector = null,

    /// The IDs of subnets to launch a `Pod` into. A `Pod` running on
    /// Fargate isn't assigned a public IP address, so only private subnets (with no
    /// direct
    /// route to an Internet Gateway) are accepted for this parameter.
    subnets: ?[]const []const u8 = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .fargate_profile_name = "fargateProfileName",
        .pod_execution_role_arn = "podExecutionRoleArn",
        .selectors = "selectors",
        .subnets = "subnets",
        .tags = "tags",
    };
};

pub const CreateFargateProfileOutput = struct {
    /// The full description of your new Fargate profile.
    fargate_profile: ?FargateProfile = null,

    pub const json_field_names = .{
        .fargate_profile = "fargateProfile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFargateProfileInput, options: CallOptions) !CreateFargateProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFargateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/fargate-profiles");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fargateProfileName\":");
    try aws.json.writeValue(@TypeOf(input.fargate_profile_name), input.fargate_profile_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"podExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.pod_execution_role_arn), input.pod_execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.selectors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"selectors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subnets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subnets\":");
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFargateProfileOutput {
    var result: CreateFargateProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFargateProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
