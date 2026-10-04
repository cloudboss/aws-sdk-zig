const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrainingPlanExtension = @import("training_plan_extension.zig").TrainingPlanExtension;

pub const DescribeTrainingPlanExtensionHistoryInput = struct {
    /// The maximum number of extensions to return in the response.
    max_results: ?i32 = null,

    /// A token to continue pagination if more results are available.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN); of the training plan to retrieve extension
    /// history for.
    training_plan_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .training_plan_arn = "TrainingPlanArn",
    };
};

pub const DescribeTrainingPlanExtensionHistoryOutput = struct {
    /// A token to continue pagination if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of extensions for the specified training plan.
    training_plan_extensions: ?[]const TrainingPlanExtension = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .training_plan_extensions = "TrainingPlanExtensions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrainingPlanExtensionHistoryInput, options: CallOptions) !DescribeTrainingPlanExtensionHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrainingPlanExtensionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeTrainingPlanExtensionHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrainingPlanExtensionHistoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeTrainingPlanExtensionHistoryOutput, body, allocator);
}
