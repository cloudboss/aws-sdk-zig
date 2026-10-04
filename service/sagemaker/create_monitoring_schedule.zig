const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitoringScheduleConfig = @import("monitoring_schedule_config.zig").MonitoringScheduleConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateMonitoringScheduleInput = struct {
    /// The configuration object that specifies the monitoring schedule and defines
    /// the monitoring job.
    monitoring_schedule_config: MonitoringScheduleConfig,

    /// The name of the monitoring schedule. The name must be unique within an
    /// Amazon Web Services Region within an Amazon Web Services account.
    monitoring_schedule_name: []const u8,

    /// (Optional) An array of key-value pairs. For more information, see [Using
    /// Cost Allocation Tags](
    /// https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html#allocation-whatURL) in the *Amazon Web Services Billing and Cost Management User Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .monitoring_schedule_config = "MonitoringScheduleConfig",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .tags = "Tags",
    };
};

pub const CreateMonitoringScheduleOutput = struct {
    /// The Amazon Resource Name (ARN) of the monitoring schedule.
    monitoring_schedule_arn: []const u8,

    pub const json_field_names = .{
        .monitoring_schedule_arn = "MonitoringScheduleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMonitoringScheduleInput, options: CallOptions) !CreateMonitoringScheduleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMonitoringScheduleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateMonitoringSchedule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMonitoringScheduleOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateMonitoringScheduleOutput, body, allocator);
}
