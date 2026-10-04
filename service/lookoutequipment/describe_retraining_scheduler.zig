const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelPromoteMode = @import("model_promote_mode.zig").ModelPromoteMode;
const RetrainingSchedulerStatus = @import("retraining_scheduler_status.zig").RetrainingSchedulerStatus;

pub const DescribeRetrainingSchedulerInput = struct {
    /// The name of the model that the retraining scheduler is attached to.
    model_name: []const u8,

    pub const json_field_names = .{
        .model_name = "ModelName",
    };
};

pub const DescribeRetrainingSchedulerOutput = struct {
    /// Indicates the time and date at which the retraining scheduler was created.
    created_at: ?i64 = null,

    /// The number of past days of data used for retraining.
    lookback_window: ?[]const u8 = null,

    /// The ARN of the model that the retraining scheduler is attached to.
    model_arn: ?[]const u8 = null,

    /// The name of the model that the retraining scheduler is attached to.
    model_name: ?[]const u8 = null,

    /// Indicates how the service uses new models. In `MANAGED` mode, new models are
    /// used for inference if they have better performance than the current model.
    /// In
    /// `MANUAL` mode, the new models are not used until they are [manually
    /// activated](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/versioning-model.html#model-activation).
    promote_mode: ?ModelPromoteMode = null,

    /// The frequency at which the model retraining is set. This follows the [ISO
    /// 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)
    /// guidelines.
    retraining_frequency: ?[]const u8 = null,

    /// The start date for the retraining scheduler. Lookout for Equipment truncates
    /// the time you provide to the
    /// nearest UTC day.
    retraining_start_date: ?i64 = null,

    /// The status of the retraining scheduler.
    status: ?RetrainingSchedulerStatus = null,

    /// Indicates the time and date at which the retraining scheduler was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .lookback_window = "LookbackWindow",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .promote_mode = "PromoteMode",
        .retraining_frequency = "RetrainingFrequency",
        .retraining_start_date = "RetrainingStartDate",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRetrainingSchedulerInput, options: CallOptions) !DescribeRetrainingSchedulerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRetrainingSchedulerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeRetrainingScheduler");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRetrainingSchedulerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRetrainingSchedulerOutput, body, allocator);
}
