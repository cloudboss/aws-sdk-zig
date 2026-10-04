const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueprintOptimizationObject = @import("blueprint_optimization_object.zig").BlueprintOptimizationObject;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const BlueprintOptimizationOutputConfiguration = @import("blueprint_optimization_output_configuration.zig").BlueprintOptimizationOutputConfiguration;
const BlueprintOptimizationSample = @import("blueprint_optimization_sample.zig").BlueprintOptimizationSample;
const Tag = @import("tag.zig").Tag;

pub const InvokeBlueprintOptimizationAsyncInput = struct {
    /// Blueprint to be optimized
    blueprint: BlueprintOptimizationObject,

    /// Data automation profile ARN
    data_automation_profile_arn: []const u8,

    /// Encryption configuration.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Output configuration where the results should be placed
    output_configuration: BlueprintOptimizationOutputConfiguration,

    /// List of Blueprint Optimization Samples
    samples: []const BlueprintOptimizationSample,

    /// List of tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .blueprint = "blueprint",
        .data_automation_profile_arn = "dataAutomationProfileArn",
        .encryption_configuration = "encryptionConfiguration",
        .output_configuration = "outputConfiguration",
        .samples = "samples",
        .tags = "tags",
    };
};

pub const InvokeBlueprintOptimizationAsyncOutput = struct {
    /// ARN of the blueprint optimization job
    invocation_arn: []const u8,

    pub const json_field_names = .{
        .invocation_arn = "invocationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeBlueprintOptimizationAsyncInput, options: CallOptions) !InvokeBlueprintOptimizationAsyncOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeBlueprintOptimizationAsyncInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-data-automation", "Bedrock Data Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/invokeBlueprintOptimizationAsync";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"blueprint\":");
    try aws.json.writeValue(@TypeOf(input.blueprint), input.blueprint, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataAutomationProfileArn\":");
    try aws.json.writeValue(@TypeOf(input.data_automation_profile_arn), input.data_automation_profile_arn, allocator, &body_buf);
    has_prev = true;
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.output_configuration), input.output_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"samples\":");
    try aws.json.writeValue(@TypeOf(input.samples), input.samples, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeBlueprintOptimizationAsyncOutput {
    var result: InvokeBlueprintOptimizationAsyncOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(InvokeBlueprintOptimizationAsyncOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
