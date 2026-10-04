const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalingPlanResource = @import("scaling_plan_resource.zig").ScalingPlanResource;

pub const DescribeScalingPlanResourcesInput = struct {
    /// The maximum number of scalable resources to return. The value must be
    /// between
    /// 1 and 50. The default value is 50.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the scaling plan.
    scaling_plan_name: []const u8,

    /// The version number of the scaling plan. Currently, the only valid value is
    /// `1`.
    scaling_plan_version: i64,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .scaling_plan_name = "ScalingPlanName",
        .scaling_plan_version = "ScalingPlanVersion",
    };
};

pub const DescribeScalingPlanResourcesOutput = struct {
    /// The token required to get the next set of results. This value is `null` if
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the scalable resources.
    scaling_plan_resources: ?[]const ScalingPlanResource = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .scaling_plan_resources = "ScalingPlanResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScalingPlanResourcesInput, options: CallOptions) !DescribeScalingPlanResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScalingPlanResourcesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleScalingPlannerFrontendService.DescribeScalingPlanResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScalingPlanResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeScalingPlanResourcesOutput, body, allocator);
}
