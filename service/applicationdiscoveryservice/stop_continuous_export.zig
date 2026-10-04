const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StopContinuousExportInput = struct {
    /// The unique ID assigned to this export.
    export_id: []const u8,

    pub const json_field_names = .{
        .export_id = "exportId",
    };
};

pub const StopContinuousExportOutput = struct {
    /// Timestamp that represents when this continuous export started collecting
    /// data.
    start_time: ?i64 = null,

    /// Timestamp that represents when this continuous export was stopped.
    stop_time: ?i64 = null,

    pub const json_field_names = .{
        .start_time = "startTime",
        .stop_time = "stopTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopContinuousExportInput, options: CallOptions) !StopContinuousExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopContinuousExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.StopContinuousExport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopContinuousExportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopContinuousExportOutput, body, allocator);
}
