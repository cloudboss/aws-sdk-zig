const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CostAllocationTagStatusEntry = @import("cost_allocation_tag_status_entry.zig").CostAllocationTagStatusEntry;
const UpdateCostAllocationTagsStatusError = @import("update_cost_allocation_tags_status_error.zig").UpdateCostAllocationTagsStatusError;

pub const UpdateCostAllocationTagsStatusInput = struct {
    /// The list of `CostAllocationTagStatusEntry` objects that are used to update
    /// cost
    /// allocation tags status for this request.
    cost_allocation_tags_status: []const CostAllocationTagStatusEntry,

    pub const json_field_names = .{
        .cost_allocation_tags_status = "CostAllocationTagsStatus",
    };
};

pub const UpdateCostAllocationTagsStatusOutput = struct {
    /// A list of `UpdateCostAllocationTagsStatusError` objects with error details
    /// about each cost allocation tag that can't be updated. If there's no failure,
    /// an empty array
    /// returns.
    errors: ?[]const UpdateCostAllocationTagsStatusError = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCostAllocationTagsStatusInput, options: CallOptions) !UpdateCostAllocationTagsStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCostAllocationTagsStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.UpdateCostAllocationTagsStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCostAllocationTagsStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCostAllocationTagsStatusOutput, body, allocator);
}
