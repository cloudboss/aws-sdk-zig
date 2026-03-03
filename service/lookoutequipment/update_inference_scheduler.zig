const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceInputConfiguration = @import("inference_input_configuration.zig").InferenceInputConfiguration;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const DataUploadFrequency = @import("data_upload_frequency.zig").DataUploadFrequency;

pub const UpdateInferenceSchedulerInput = struct {
    /// A period of time (in minutes) by which inference on the data is delayed
    /// after the data
    /// starts. For instance, if you select an offset delay time of five minutes,
    /// inference will
    /// not begin on the data until the first data measurement after the five minute
    /// mark. For
    /// example, if five minutes is selected, the inference scheduler will wake up
    /// at the
    /// configured frequency with the additional five minute delay time to check the
    /// customer S3
    /// bucket. The customer can upload data at the same frequency and they don't
    /// need to stop and
    /// restart the scheduler when uploading new data.
    data_delay_offset_in_minutes: ?i64 = null,

    /// Specifies information for the input data for the inference scheduler,
    /// including
    /// delimiter, format, and dataset location.
    data_input_configuration: ?InferenceInputConfiguration = null,

    /// Specifies information for the output results from the inference scheduler,
    /// including
    /// the output S3 location.
    data_output_configuration: ?InferenceOutputConfiguration = null,

    /// How often data is uploaded to the source S3 bucket for the input data. The
    /// value chosen
    /// is the length of time between data uploads. For instance, if you select 5
    /// minutes, Amazon
    /// Lookout for Equipment will upload the real-time data to the source bucket
    /// once every 5
    /// minutes. This frequency also determines how often Amazon Lookout for
    /// Equipment starts a scheduled inference on
    /// your data. In this example, it starts once every 5 minutes.
    data_upload_frequency: ?DataUploadFrequency = null,

    /// The name of the inference scheduler to be updated.
    inference_scheduler_name: []const u8,

    /// The Amazon Resource Name (ARN) of a role with permission to access the data
    /// source for
    /// the inference scheduler.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_delay_offset_in_minutes = "DataDelayOffsetInMinutes",
        .data_input_configuration = "DataInputConfiguration",
        .data_output_configuration = "DataOutputConfiguration",
        .data_upload_frequency = "DataUploadFrequency",
        .inference_scheduler_name = "InferenceSchedulerName",
        .role_arn = "RoleArn",
    };
};

const UpdateInferenceSchedulerOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInferenceSchedulerInput, options: Options) !UpdateInferenceSchedulerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lookoutequipment");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInferenceSchedulerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.UpdateInferenceScheduler");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInferenceSchedulerOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
