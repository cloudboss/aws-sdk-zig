const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceSyncBlockerSummary = @import("service_sync_blocker_summary.zig").ServiceSyncBlockerSummary;

pub const GetServiceSyncBlockerSummaryInput = struct {
    /// The name of the service instance that you want to get the service sync
    /// blocker summary
    /// for. If given bothe the instance name and the service name, only the
    /// instance is
    /// blocked.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service that you want to get the service sync blocker
    /// summary for. If
    /// given only the service name, all instances are blocked.
    service_name: []const u8,

    pub const json_field_names = .{
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
    };
};

pub const GetServiceSyncBlockerSummaryOutput = struct {
    /// The detailed data of the requested service sync blocker summary.
    service_sync_blocker_summary: ?ServiceSyncBlockerSummary = null,

    pub const json_field_names = .{
        .service_sync_blocker_summary = "serviceSyncBlockerSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceSyncBlockerSummaryInput, options: CallOptions) !GetServiceSyncBlockerSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceSyncBlockerSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.GetServiceSyncBlockerSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceSyncBlockerSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetServiceSyncBlockerSummaryOutput, body, allocator);
}
