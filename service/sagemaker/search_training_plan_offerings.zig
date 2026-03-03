const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ReservedCapacityInstanceType = @import("reserved_capacity_instance_type.zig").ReservedCapacityInstanceType;
const SageMakerResourceName = @import("sage_maker_resource_name.zig").SageMakerResourceName;
const TrainingPlanOffering = @import("training_plan_offering.zig").TrainingPlanOffering;

pub const SearchTrainingPlanOfferingsInput = struct {
    /// The desired duration in hours for the training plan offerings.
    duration_hours: ?i64 = null,

    /// A filter to search for reserved capacity offerings with an end time before a
    /// specified date.
    end_time_before: ?i64 = null,

    /// The number of instances you want to reserve in the training plan offerings.
    /// This allows you to specify the quantity of compute resources needed for your
    /// SageMaker training jobs or SageMaker HyperPod clusters, helping you find
    /// reserved capacity offerings that match your requirements.
    instance_count: ?i32 = null,

    /// The type of instance you want to search for in the available training plan
    /// offerings. This field allows you to filter the search results based on the
    /// specific compute resources you require for your SageMaker training jobs or
    /// SageMaker HyperPod clusters. When searching for training plan offerings,
    /// specifying the instance type helps you find Reserved Instances that match
    /// your computational needs.
    instance_type: ?ReservedCapacityInstanceType = null,

    /// A filter to search for training plan offerings with a start time after a
    /// specified date.
    start_time_after: ?i64 = null,

    /// The target resources (e.g., SageMaker Training Jobs, SageMaker HyperPod,
    /// SageMaker Endpoints) to search for in the offerings.
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

    /// The number of UltraServers to search for.
    ultra_server_count: ?i32 = null,

    /// The type of UltraServer to search for, such as ml.u-p6e-gb200x72.
    ultra_server_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration_hours = "DurationHours",
        .end_time_before = "EndTimeBefore",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .start_time_after = "StartTimeAfter",
        .target_resources = "TargetResources",
        .ultra_server_count = "UltraServerCount",
        .ultra_server_type = "UltraServerType",
    };
};

pub const SearchTrainingPlanOfferingsOutput = struct {
    /// A list of training plan offerings that match the search criteria.
    training_plan_offerings: ?[]const TrainingPlanOffering = null,

    pub const json_field_names = .{
        .training_plan_offerings = "TrainingPlanOfferings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchTrainingPlanOfferingsInput, options: CallOptions) !SearchTrainingPlanOfferingsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SearchTrainingPlanOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.SearchTrainingPlanOfferings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchTrainingPlanOfferingsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(SearchTrainingPlanOfferingsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
