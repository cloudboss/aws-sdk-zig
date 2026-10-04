const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngineConfiguration = @import("engine_configuration.zig").EngineConfiguration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const SessionConfiguration = @import("session_configuration.zig").SessionConfiguration;
const SessionStatistics = @import("session_statistics.zig").SessionStatistics;
const SessionStatus = @import("session_status.zig").SessionStatus;

pub const GetSessionInput = struct {
    /// The session ID.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "SessionId",
    };
};

pub const GetSessionOutput = struct {
    /// The session description.
    description: ?[]const u8 = null,

    /// Contains engine configuration information like DPU usage.
    engine_configuration: ?EngineConfiguration = null,

    /// The engine version used by the session (for example, `PySpark engine version
    /// 3`). You can get a list of engine versions by calling ListEngineVersions.
    engine_version: ?[]const u8 = null,

    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The notebook version.
    notebook_version: ?[]const u8 = null,

    /// Contains the workgroup configuration information used by the session.
    session_configuration: ?SessionConfiguration = null,

    /// The session ID.
    session_id: ?[]const u8 = null,

    /// Contains the DPU execution time.
    statistics: ?SessionStatistics = null,

    /// Contains information about the status of the session.
    status: ?SessionStatus = null,

    /// The workgroup to which the session belongs.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .engine_configuration = "EngineConfiguration",
        .engine_version = "EngineVersion",
        .monitoring_configuration = "MonitoringConfiguration",
        .notebook_version = "NotebookVersion",
        .session_configuration = "SessionConfiguration",
        .session_id = "SessionId",
        .statistics = "Statistics",
        .status = "Status",
        .work_group = "WorkGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionInput, options: CallOptions) !GetSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.GetSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSessionOutput, body, allocator);
}
