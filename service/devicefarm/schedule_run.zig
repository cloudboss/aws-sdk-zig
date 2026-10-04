const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleRunConfiguration = @import("schedule_run_configuration.zig").ScheduleRunConfiguration;
const DeviceSelectionConfiguration = @import("device_selection_configuration.zig").DeviceSelectionConfiguration;
const ExecutionConfiguration = @import("execution_configuration.zig").ExecutionConfiguration;
const ScheduleRunTest = @import("schedule_run_test.zig").ScheduleRunTest;
const Run = @import("run.zig").Run;

pub const ScheduleRunInput = struct {
    /// The ARN of an application package to run tests against, created with
    /// CreateUpload.
    /// See ListUploads.
    app_arn: ?[]const u8 = null,

    /// Information about the settings for the run to be scheduled.
    configuration: ?ScheduleRunConfiguration = null,

    /// The ARN of the device pool for the run to be scheduled.
    device_pool_arn: ?[]const u8 = null,

    /// The filter criteria used to dynamically select a set of devices for a test
    /// run and the maximum number of
    /// devices to be included in the run.
    ///
    /// Either **
    /// `devicePoolArn`
    /// ** or **
    /// `deviceSelectionConfiguration`
    /// ** is required in a
    /// request.
    device_selection_configuration: ?DeviceSelectionConfiguration = null,

    /// Specifies configuration information about a test run, such as the execution
    /// timeout
    /// (in minutes).
    execution_configuration: ?ExecutionConfiguration = null,

    /// The name for the run to be scheduled.
    name: ?[]const u8 = null,

    /// The ARN of the project for the run to be scheduled.
    project_arn: []const u8,

    /// Information about the test for the run to be scheduled.
    @"test": ScheduleRunTest,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .configuration = "configuration",
        .device_pool_arn = "devicePoolArn",
        .device_selection_configuration = "deviceSelectionConfiguration",
        .execution_configuration = "executionConfiguration",
        .name = "name",
        .project_arn = "projectArn",
        .@"test" = "test",
    };
};

pub const ScheduleRunOutput = struct {
    /// Information about the scheduled run.
    run: ?Run = null,

    pub const json_field_names = .{
        .run = "run",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ScheduleRunInput, options: CallOptions) !ScheduleRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ScheduleRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.ScheduleRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ScheduleRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ScheduleRunOutput, body, allocator);
}
