const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableMaintenanceJobStatusValue = @import("table_maintenance_job_status_value.zig").TableMaintenanceJobStatusValue;

pub const GetTableMaintenanceJobStatusInput = struct {
    /// The name of the table containing the maintenance job status you want to
    /// check.
    name: []const u8,

    /// The name of the namespace the table is associated with.
    namespace: []const u8,

    /// The Amazon Resource Name (ARN) of the table bucket.
    table_bucket_arn: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
        .table_bucket_arn = "tableBucketARN",
    };
};

pub const GetTableMaintenanceJobStatusOutput = struct {
    /// The status of the maintenance job.
    status: ?[]const aws.map.MapEntry(TableMaintenanceJobStatusValue) = null,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .table_arn = "tableARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableMaintenanceJobStatusInput, options: CallOptions) !GetTableMaintenanceJobStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3tables", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableMaintenanceJobStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tables/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/maintenance-job-status");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableMaintenanceJobStatusOutput {
    const result: GetTableMaintenanceJobStatusOutput = try aws.json.parseJsonObject(
        GetTableMaintenanceJobStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
