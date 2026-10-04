const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailedResource = @import("failed_resource.zig").FailedResource;
const PendingResource = @import("pending_resource.zig").PendingResource;

pub const UngroupResourcesInput = struct {
    /// The name or the Amazon resource name (ARN) of the resource group from which
    /// to remove the resources.
    group: []const u8,

    /// The Amazon resource names (ARNs) of the resources to be removed from the
    /// group.
    resource_arns: []const []const u8,

    pub const json_field_names = .{
        .group = "Group",
        .resource_arns = "ResourceArns",
    };
};

pub const UngroupResourcesOutput = struct {
    /// A list of any resources that failed to be removed from the group by this
    /// operation.
    failed: ?[]const FailedResource = null,

    /// A list of any resources that are still in the process of being removed from
    /// the group
    /// by this operation. These pending removals continue asynchronously. You can
    /// check the
    /// status of pending removals by using the `
    /// ListGroupResources
    /// ` operation. After the resource is successfully removed, it no longer
    /// appears in the response.
    pending: ?[]const PendingResource = null,

    /// A list of resources that were successfully removed from the group by this
    /// operation.
    succeeded: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .pending = "Pending",
        .succeeded = "Succeeded",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UngroupResourcesInput, options: CallOptions) !UngroupResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UngroupResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ungroup-resources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Group\":");
    try aws.json.writeValue(@TypeOf(input.group), input.group, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArns\":");
    try aws.json.writeValue(@TypeOf(input.resource_arns), input.resource_arns, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UngroupResourcesOutput {
    const result: UngroupResourcesOutput = try aws.json.parseJsonObject(
        UngroupResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
