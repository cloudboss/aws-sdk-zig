const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReservedCapacitySummary = @import("reserved_capacity_summary.zig").ReservedCapacitySummary;
const TrainingPlanStatus = @import("training_plan_status.zig").TrainingPlanStatus;
const SageMakerResourceName = @import("sage_maker_resource_name.zig").SageMakerResourceName;

pub const DescribeTrainingPlanInput = struct {
    /// The name of the training plan to describe.
    training_plan_name: []const u8,

    pub const json_field_names = .{
        .training_plan_name = "TrainingPlanName",
    };
};

pub const DescribeTrainingPlanOutput = struct {
    /// The number of instances currently available for use in this training plan.
    available_instance_count: ?i32 = null,

    /// The number of available spare instances in the training plan.
    available_spare_instance_count: ?i32 = null,

    /// The currency code for the upfront fee (e.g., USD).
    currency_code: ?[]const u8 = null,

    /// The number of whole hours in the total duration for this training plan.
    duration_hours: ?i64 = null,

    /// The additional minutes beyond whole hours in the total duration for this
    /// training plan.
    duration_minutes: ?i64 = null,

    /// The end time of the training plan.
    end_time: ?i64 = null,

    /// The number of instances currently in use from this training plan.
    in_use_instance_count: ?i32 = null,

    /// The list of Reserved Capacity providing the underlying compute resources of
    /// the plan.
    reserved_capacity_summaries: ?[]const ReservedCapacitySummary = null,

    /// The start time of the training plan.
    start_time: ?i64 = null,

    /// The current status of the training plan (e.g., Pending, Active, Expired). To
    /// see the complete list of status values available for a training plan, refer
    /// to the `Status` attribute within the `
    /// [TrainingPlanSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingPlanSummary.html) ` object.
    status: TrainingPlanStatus,

    /// A message providing additional information about the current status of the
    /// training plan.
    status_message: ?[]const u8 = null,

    /// The target resources (e.g., SageMaker Training Jobs, SageMaker HyperPod,
    /// SageMaker Endpoints) that can use this training plan.
    ///
    /// Training plans are specific to their target resource.
    ///
    /// * A training plan designed for SageMaker training jobs can only be used to
    ///   schedule and run training jobs.
    /// * A training plan for HyperPod clusters can be used exclusively to provide
    ///   compute resources to a cluster's instance group.
    /// * A training plan for SageMaker endpoints can be used exclusively to provide
    ///   compute resources to SageMaker endpoints for model deployment.
    target_resources: ?[]const SageMakerResourceName = null,

    /// The total number of instances reserved in this training plan.
    total_instance_count: ?i32 = null,

    /// The total number of UltraServers reserved to this training plan.
    total_ultra_server_count: ?i32 = null,

    /// The Amazon Resource Name (ARN); of the training plan.
    training_plan_arn: []const u8,

    /// The name of the training plan.
    training_plan_name: []const u8,

    /// The number of instances in the training plan that are currently in an
    /// unhealthy state.
    unhealthy_instance_count: ?i32 = null,

    /// The upfront fee for the training plan.
    upfront_fee: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_instance_count = "AvailableInstanceCount",
        .available_spare_instance_count = "AvailableSpareInstanceCount",
        .currency_code = "CurrencyCode",
        .duration_hours = "DurationHours",
        .duration_minutes = "DurationMinutes",
        .end_time = "EndTime",
        .in_use_instance_count = "InUseInstanceCount",
        .reserved_capacity_summaries = "ReservedCapacitySummaries",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
        .target_resources = "TargetResources",
        .total_instance_count = "TotalInstanceCount",
        .total_ultra_server_count = "TotalUltraServerCount",
        .training_plan_arn = "TrainingPlanArn",
        .training_plan_name = "TrainingPlanName",
        .unhealthy_instance_count = "UnhealthyInstanceCount",
        .upfront_fee = "UpfrontFee",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrainingPlanInput, options: Options) !DescribeTrainingPlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeTrainingPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeTrainingPlan");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeTrainingPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeTrainingPlanOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
