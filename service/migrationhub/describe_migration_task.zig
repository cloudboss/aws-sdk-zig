const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationTask = @import("migration_task.zig").MigrationTask;

pub const DescribeMigrationTaskInput = struct {
    /// The identifier given to the MigrationTask. *Do not store personal data in
    /// this
    /// field.*
    migration_task_name: []const u8,

    /// The name of the ProgressUpdateStream.
    progress_update_stream: []const u8,

    pub const json_field_names = .{
        .migration_task_name = "MigrationTaskName",
        .progress_update_stream = "ProgressUpdateStream",
    };
};

pub const DescribeMigrationTaskOutput = struct {
    /// Object encapsulating information about the migration task.
    migration_task: ?MigrationTask = null,

    pub const json_field_names = .{
        .migration_task = "MigrationTask",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMigrationTaskInput, options: CallOptions) !DescribeMigrationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMigrationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.DescribeMigrationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMigrationTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMigrationTaskOutput, body, allocator);
}
