const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BulkDeploymentMetrics = @import("bulk_deployment_metrics.zig").BulkDeploymentMetrics;
const BulkDeploymentStatus = @import("bulk_deployment_status.zig").BulkDeploymentStatus;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;

pub const GetBulkDeploymentStatusInput = struct {
    /// The ID of the bulk deployment.
    bulk_deployment_id: []const u8,

    pub const json_field_names = .{
        .bulk_deployment_id = "BulkDeploymentId",
    };
};

pub const GetBulkDeploymentStatusOutput = struct {
    /// Relevant metrics on input records processed during bulk deployment.
    bulk_deployment_metrics: ?BulkDeploymentMetrics = null,

    /// The status of the bulk deployment.
    bulk_deployment_status: ?BulkDeploymentStatus = null,

    /// The time, in ISO format, when the deployment was created.
    created_at: ?[]const u8 = null,

    /// Error details
    error_details: ?[]const ErrorDetail = null,

    /// Error message
    error_message: ?[]const u8 = null,

    /// Tag(s) attached to the resource arn.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .bulk_deployment_metrics = "BulkDeploymentMetrics",
        .bulk_deployment_status = "BulkDeploymentStatus",
        .created_at = "CreatedAt",
        .error_details = "ErrorDetails",
        .error_message = "ErrorMessage",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBulkDeploymentStatusInput, options: CallOptions) !GetBulkDeploymentStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBulkDeploymentStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/bulk/deployments/");
    try path_buf.appendSlice(allocator, input.bulk_deployment_id);
    try path_buf.appendSlice(allocator, "/status");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBulkDeploymentStatusOutput {
    const result: GetBulkDeploymentStatusOutput = try aws.json.parseJsonObject(
        GetBulkDeploymentStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
