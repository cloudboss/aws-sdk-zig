const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateTrainingPlanInput = struct {
    /// Number of spare instances to reserve per UltraServer for enhanced
    /// resiliency. Default is 1.
    spare_instance_count_per_ultra_server: ?i32 = null,

    /// An array of key-value pairs to apply to this training plan.
    tags: ?[]const Tag = null,

    /// The name of the training plan to create.
    training_plan_name: []const u8,

    /// The unique identifier of the training plan offering to use for creating this
    /// plan.
    training_plan_offering_id: []const u8,

    pub const json_field_names = .{
        .spare_instance_count_per_ultra_server = "SpareInstanceCountPerUltraServer",
        .tags = "Tags",
        .training_plan_name = "TrainingPlanName",
        .training_plan_offering_id = "TrainingPlanOfferingId",
    };
};

pub const CreateTrainingPlanOutput = struct {
    /// The Amazon Resource Name (ARN); of the created training plan.
    training_plan_arn: []const u8,

    pub const json_field_names = .{
        .training_plan_arn = "TrainingPlanArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrainingPlanInput, options: CallOptions) !CreateTrainingPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrainingPlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTrainingPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrainingPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTrainingPlanOutput, body, allocator);
}
