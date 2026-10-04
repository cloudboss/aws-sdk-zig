const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StopApplicationInput = struct {
    /// The name of the running application to stop.
    application_name: []const u8,

    /// Set to `true` to force the application to stop. If you set `Force`
    /// to `true`, Managed Service for Apache Flink stops the application without
    /// taking a snapshot.
    ///
    /// Force-stopping your application may lead to data loss or duplication.
    /// To prevent data loss or duplicate processing of data during application
    /// restarts,
    /// we recommend you to take frequent snapshots of your application.
    ///
    /// You can only force stop a Managed Service for Apache Flink application. You
    /// can't force stop a SQL-based Kinesis Data Analytics application.
    ///
    /// The application must be in the
    /// `STARTING`, `UPDATING`, `STOPPING`, `AUTOSCALING`, or
    /// `RUNNING` status.
    force: ?bool = null,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .force = "Force",
    };
};

pub const StopApplicationOutput = struct {
    /// The operation ID that can be used to track the request.
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopApplicationInput, options: CallOptions) !StopApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.StopApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopApplicationOutput, body, allocator);
}
