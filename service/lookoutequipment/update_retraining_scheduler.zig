const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelPromoteMode = @import("model_promote_mode.zig").ModelPromoteMode;

pub const UpdateRetrainingSchedulerInput = struct {
    /// The number of past days of data that will be used for retraining.
    lookback_window: ?[]const u8 = null,

    /// The name of the model whose retraining scheduler you want to update.
    model_name: []const u8,

    /// Indicates how the service will use new models. In `MANAGED` mode, new models
    /// will automatically be used for inference if they have better performance
    /// than the current
    /// model. In `MANUAL` mode, the new models will not be used [until they
    /// are manually
    /// activated](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/versioning-model.html#model-activation).
    promote_mode: ?ModelPromoteMode = null,

    /// This parameter uses the [ISO
    /// 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations) standard to set the
    /// frequency at which you want retraining to occur in
    /// terms of Years, Months, and/or Days (note: other parameters like Time are
    /// not currently
    /// supported). The minimum value is 30 days (P30D) and the maximum value is 1
    /// year (P1Y). For
    /// example, the following values are valid:
    ///
    /// * P3M15D – Every 3 months and 15 days
    ///
    /// * P2M – Every 2 months
    ///
    /// * P150D – Every 150 days
    retraining_frequency: ?[]const u8 = null,

    /// The start date for the retraining scheduler. Lookout for Equipment truncates
    /// the time you provide to the
    /// nearest UTC day.
    retraining_start_date: ?i64 = null,

    pub const json_field_names = .{
        .lookback_window = "LookbackWindow",
        .model_name = "ModelName",
        .promote_mode = "PromoteMode",
        .retraining_frequency = "RetrainingFrequency",
        .retraining_start_date = "RetrainingStartDate",
    };
};

pub const UpdateRetrainingSchedulerOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRetrainingSchedulerInput, options: CallOptions) !UpdateRetrainingSchedulerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRetrainingSchedulerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.UpdateRetrainingScheduler");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRetrainingSchedulerOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
