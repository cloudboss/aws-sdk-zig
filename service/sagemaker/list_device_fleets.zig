const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListDeviceFleetsSortBy = @import("list_device_fleets_sort_by.zig").ListDeviceFleetsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const DeviceFleetSummary = @import("device_fleet_summary.zig").DeviceFleetSummary;

pub const ListDeviceFleetsInput = struct {
    /// Filter fleets where packaging job was created after specified time.
    creation_time_after: ?i64 = null,

    /// Filter fleets where the edge packaging job was created before specified
    /// time.
    creation_time_before: ?i64 = null,

    /// Select fleets where the job was updated after X
    last_modified_time_after: ?i64 = null,

    /// Select fleets where the job was updated before X
    last_modified_time_before: ?i64 = null,

    /// The maximum number of results to select.
    max_results: ?i32 = null,

    /// Filter for fleets containing this name in their fleet device name.
    name_contains: ?[]const u8 = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The column to sort by.
    sort_by: ?ListDeviceFleetsSortBy = null,

    /// What direction to sort in.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListDeviceFleetsOutput = struct {
    /// Summary of the device fleet.
    device_fleet_summaries: ?[]const DeviceFleetSummary = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_fleet_summaries = "DeviceFleetSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeviceFleetsInput, options: CallOptions) !ListDeviceFleetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeviceFleetsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListDeviceFleets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeviceFleetsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListDeviceFleetsOutput, body, allocator);
}
