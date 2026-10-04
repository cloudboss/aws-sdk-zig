const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const SyncBlockerSummary = @import("sync_blocker_summary.zig").SyncBlockerSummary;

pub const GetSyncBlockerSummaryInput = struct {
    /// The name of the Amazon Web Services resource currently blocked from
    /// automatically being synced from a Git repository.
    resource_name: []const u8,

    /// The sync type for the sync blocker summary.
    sync_type: SyncConfigurationType,

    pub const json_field_names = .{
        .resource_name = "ResourceName",
        .sync_type = "SyncType",
    };
};

pub const GetSyncBlockerSummaryOutput = struct {
    /// The list of sync blockers for a specified resource.
    sync_blocker_summary: ?SyncBlockerSummary = null,

    pub const json_field_names = .{
        .sync_blocker_summary = "SyncBlockerSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSyncBlockerSummaryInput, options: CallOptions) !GetSyncBlockerSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSyncBlockerSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.GetSyncBlockerSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSyncBlockerSummaryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetSyncBlockerSummaryOutput, body, allocator);
}
