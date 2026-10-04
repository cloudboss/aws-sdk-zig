const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderScalingConfig = @import("capacity_provider_scaling_config.zig").CapacityProviderScalingConfig;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const CapacityProviderPermissionsConfig = @import("capacity_provider_permissions_config.zig").CapacityProviderPermissionsConfig;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const CapacityProviderTelemetryConfig = @import("capacity_provider_telemetry_config.zig").CapacityProviderTelemetryConfig;
const CapacityProviderVpcConfig = @import("capacity_provider_vpc_config.zig").CapacityProviderVpcConfig;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;

pub const CreateCapacityProviderInput = struct {
    /// The name of the capacity provider.
    capacity_provider_name: []const u8,

    /// The scaling configuration that defines how the capacity provider scales
    /// compute instances, including maximum vCPU count and scaling policies.
    capacity_provider_scaling_config: ?CapacityProviderScalingConfig = null,

    /// The instance requirements that specify the compute instance characteristics,
    /// including architectures and allowed or excluded instance types.
    instance_requirements: ?InstanceRequirements = null,

    /// The ARN of the KMS key used to encrypt data associated with the capacity
    /// provider.
    kms_key_arn: ?[]const u8 = null,

    /// The permissions configuration that specifies the IAM role ARN used by the
    /// capacity provider to manage compute resources.
    permissions_config: CapacityProviderPermissionsConfig,

    /// The tag propagation configuration for the capacity provider. Specifies tags
    /// to apply to managed resources at launch.
    propagate_tags: ?PropagateTags = null,

    /// A list of tags to associate with the capacity provider.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The telemetry configuration for the capacity provider. Specifies logging
    /// settings for managed resources.
    telemetry_config: ?CapacityProviderTelemetryConfig = null,

    /// The VPC configuration for the capacity provider, including subnet IDs and
    /// security group IDs where compute instances will be launched.
    vpc_config: CapacityProviderVpcConfig,

    pub const json_field_names = .{
        .capacity_provider_name = "CapacityProviderName",
        .capacity_provider_scaling_config = "CapacityProviderScalingConfig",
        .instance_requirements = "InstanceRequirements",
        .kms_key_arn = "KmsKeyArn",
        .permissions_config = "PermissionsConfig",
        .propagate_tags = "PropagateTags",
        .tags = "Tags",
        .telemetry_config = "TelemetryConfig",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateCapacityProviderOutput = struct {
    /// Information about the capacity provider that was created.
    capacity_provider: ?CapacityProvider = null,

    pub const json_field_names = .{
        .capacity_provider = "CapacityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCapacityProviderInput, options: CallOptions) !CreateCapacityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2025-11-30/capacity-providers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CapacityProviderName\":");
    try aws.json.writeValue(@TypeOf(input.capacity_provider_name), input.capacity_provider_name, allocator, &body_buf);
    has_prev = true;
    if (input.capacity_provider_scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CapacityProviderScalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_requirements) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceRequirements\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PermissionsConfig\":");
    try aws.json.writeValue(@TypeOf(input.permissions_config), input.permissions_config, allocator, &body_buf);
    has_prev = true;
    if (input.propagate_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PropagateTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.telemetry_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TelemetryConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcConfig\":");
    try aws.json.writeValue(@TypeOf(input.vpc_config), input.vpc_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCapacityProviderOutput {
    const result: CreateCapacityProviderOutput = try aws.json.parseJsonObject(
        CreateCapacityProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
