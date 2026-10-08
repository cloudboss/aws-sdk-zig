const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableMaintenanceType = @import("table_maintenance_type.zig").TableMaintenanceType;
const TableMaintenanceConfigurationValue = @import("table_maintenance_configuration_value.zig").TableMaintenanceConfigurationValue;

pub const PutTableMaintenanceConfigurationInput = struct {
    /// The name of the table.
    name: []const u8,

    /// The namespace of the table.
    namespace: []const u8,

    /// The Amazon Resource Name (ARN) of the table associated with the maintenance
    /// configuration.
    table_bucket_arn: []const u8,

    /// The type of the maintenance configuration.
    type: TableMaintenanceType,

    /// Defines the values of the maintenance configuration for the table.
    value: TableMaintenanceConfigurationValue,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
        .table_bucket_arn = "tableBucketARN",
        .type = "type",
        .value = "value",
    };
};

pub const PutTableMaintenanceConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutTableMaintenanceConfigurationInput, options: CallOptions) !PutTableMaintenanceConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutTableMaintenanceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tables/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/maintenance/");
    try path_buf.appendSlice(allocator, input.type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"value\":");
    try aws.json.writeValue(@TypeOf(input.value), input.value, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutTableMaintenanceConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutTableMaintenanceConfigurationOutput = .{};

    return result;
}
