const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationSource = @import("application_source.zig").ApplicationSource;
const ScalingInstruction = @import("scaling_instruction.zig").ScalingInstruction;

pub const CreateScalingPlanInput = struct {
    /// A CloudFormation stack or set of tags. You can create one scaling plan per
    /// application
    /// source.
    ///
    /// For more information, see
    /// [ApplicationSource](https://docs.aws.amazon.com/autoscaling/plans/APIReference/API_ApplicationSource.html) in the *AWS Auto Scaling API Reference*.
    application_source: ApplicationSource,

    /// The scaling instructions.
    ///
    /// For more information, see
    /// [ScalingInstruction](https://docs.aws.amazon.com/autoscaling/plans/APIReference/API_ScalingInstruction.html) in the *AWS Auto Scaling API Reference*.
    scaling_instructions: []const ScalingInstruction,

    /// The name of the scaling plan. Names cannot contain vertical bars, colons, or
    /// forward
    /// slashes.
    scaling_plan_name: []const u8,

    pub const json_field_names = .{
        .application_source = "ApplicationSource",
        .scaling_instructions = "ScalingInstructions",
        .scaling_plan_name = "ScalingPlanName",
    };
};

pub const CreateScalingPlanOutput = struct {
    /// The version number of the scaling plan. This value is always `1`. Currently,
    /// you cannot have multiple scaling plan versions.
    scaling_plan_version: i64,

    pub const json_field_names = .{
        .scaling_plan_version = "ScalingPlanVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScalingPlanInput, options: CallOptions) !CreateScalingPlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling-plans", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScalingPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling-plans", "Auto Scaling Plans", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleScalingPlannerFrontendService.CreateScalingPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScalingPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateScalingPlanOutput, body, allocator);
}
