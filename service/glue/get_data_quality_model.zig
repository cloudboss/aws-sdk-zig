const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityModelStatus = @import("data_quality_model_status.zig").DataQualityModelStatus;

pub const GetDataQualityModelInput = struct {
    /// The Profile ID.
    profile_id: []const u8,

    /// The Statistic ID.
    statistic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .profile_id = "ProfileId",
        .statistic_id = "StatisticId",
    };
};

pub const GetDataQualityModelOutput = struct {
    /// The timestamp when the data quality model training completed.
    completed_on: ?i64 = null,

    /// The training failure reason.
    failure_reason: ?[]const u8 = null,

    /// The timestamp when the data quality model training started.
    started_on: ?i64 = null,

    /// The training status of the data quality model.
    status: ?DataQualityModelStatus = null,

    pub const json_field_names = .{
        .completed_on = "CompletedOn",
        .failure_reason = "FailureReason",
        .started_on = "StartedOn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataQualityModelInput, options: CallOptions) !GetDataQualityModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataQualityModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetDataQualityModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataQualityModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDataQualityModelOutput, body, allocator);
}
