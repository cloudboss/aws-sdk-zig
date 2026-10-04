const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParallelDataConfig = @import("parallel_data_config.zig").ParallelDataConfig;
const ParallelDataStatus = @import("parallel_data_status.zig").ParallelDataStatus;

pub const UpdateParallelDataInput = struct {
    /// A unique identifier for the request. This token is automatically generated
    /// when you use
    /// Amazon Translate through an AWS SDK.
    client_token: []const u8,

    /// A custom description for the parallel data resource in Amazon Translate.
    description: ?[]const u8 = null,

    /// The name of the parallel data resource being updated.
    name: []const u8,

    /// Specifies the format and S3 location of the parallel data input file.
    parallel_data_config: ParallelDataConfig,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .parallel_data_config = "ParallelDataConfig",
    };
};

pub const UpdateParallelDataOutput = struct {
    /// The time that the most recent update was attempted.
    latest_update_attempt_at: ?i64 = null,

    /// The status of the parallel data update attempt. When the updated parallel
    /// data resource is
    /// ready for you to use, the status is `ACTIVE`.
    latest_update_attempt_status: ?ParallelDataStatus = null,

    /// The name of the parallel data resource being updated.
    name: ?[]const u8 = null,

    /// The status of the parallel data resource that you are attempting to update.
    /// Your update
    /// request is accepted only if this status is either `ACTIVE` or
    /// `FAILED`.
    status: ?ParallelDataStatus = null,

    pub const json_field_names = .{
        .latest_update_attempt_at = "LatestUpdateAttemptAt",
        .latest_update_attempt_status = "LatestUpdateAttemptStatus",
        .name = "Name",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateParallelDataInput, options: CallOptions) !UpdateParallelDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "translate", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateParallelDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.UpdateParallelData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateParallelDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateParallelDataOutput, body, allocator);
}
