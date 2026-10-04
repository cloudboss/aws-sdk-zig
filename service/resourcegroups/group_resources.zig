const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailedResource = @import("failed_resource.zig").FailedResource;
const PendingResource = @import("pending_resource.zig").PendingResource;

pub const GroupResourcesInput = struct {
    /// The name or the Amazon resource name (ARN) of the resource group to add
    /// resources to.
    group: []const u8,

    /// The list of Amazon resource names (ARNs) of the resources to be added to the
    /// group.
    resource_arns: []const []const u8,

    pub const json_field_names = .{
        .group = "Group",
        .resource_arns = "ResourceArns",
    };
};

pub const GroupResourcesOutput = struct {
    /// A list of Amazon resource names (ARNs) of any resources that this operation
    /// failed to add to the group.
    failed: ?[]const FailedResource = null,

    /// A list of Amazon resource names (ARNs) of any resources that this operation
    /// is still in the process adding to
    /// the group. These pending additions continue asynchronously. You can check
    /// the status of
    /// pending additions by using the `
    /// ListGroupResources
    /// `
    /// operation, and checking the `Resources` array in the response and the
    /// `Status` field of each object in that array.
    pending: ?[]const PendingResource = null,

    /// A list of Amazon resource names (ARNs) of the resources that this operation
    /// successfully added to the
    /// group.
    succeeded: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .pending = "Pending",
        .succeeded = "Succeeded",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GroupResourcesInput, options: CallOptions) !GroupResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GroupResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/group-resources";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GroupResourcesOutput {
    const result: GroupResourcesOutput = try aws.json.parseJsonObject(
        GroupResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
