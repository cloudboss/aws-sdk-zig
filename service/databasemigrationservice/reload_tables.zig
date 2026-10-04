const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReloadOptionValue = @import("reload_option_value.zig").ReloadOptionValue;
const TableToReload = @import("table_to_reload.zig").TableToReload;

pub const ReloadTablesInput = struct {
    /// Options for reload. Specify `data-reload` to reload the data and re-validate
    /// it if validation is enabled. Specify `validate-only` to re-validate the
    /// table.
    /// This option applies only when validation is enabled for the task.
    ///
    /// Valid values: data-reload, validate-only
    ///
    /// Default value is data-reload.
    reload_option: ?ReloadOptionValue = null,

    /// The Amazon Resource Name (ARN) of the replication task.
    replication_task_arn: []const u8,

    /// The name and schema of the table to be reloaded.
    tables_to_reload: []const TableToReload,

    pub const json_field_names = .{
        .reload_option = "ReloadOption",
        .replication_task_arn = "ReplicationTaskArn",
        .tables_to_reload = "TablesToReload",
    };
};

pub const ReloadTablesOutput = struct {
    /// The Amazon Resource Name (ARN) of the replication task.
    replication_task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .replication_task_arn = "ReplicationTaskArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReloadTablesInput, options: CallOptions) !ReloadTablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ReloadTablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ReloadTables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReloadTablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ReloadTablesOutput, body, allocator);
}
