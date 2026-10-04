const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateSourceResourceInput = struct {
    /// This is an optional parameter that you can use to test whether the call will
    /// succeed.
    /// Set this parameter to `true` to verify that you have the permissions that
    /// are
    /// required to make the call, and that you have specified the other parameters
    /// in the call
    /// correctly.
    dry_run: ?bool = null,

    /// A unique identifier that references the migration task. *Do not include
    /// sensitive data in this field.*
    migration_task_name: []const u8,

    /// The name of the progress-update stream, which is used for access control as
    /// well as a
    /// namespace for migration-task names that is implicitly linked to your AWS
    /// account. The
    /// progress-update stream must uniquely identify the migration tool as it is
    /// used for all
    /// updates made by the tool; however, it does not need to be unique for each
    /// AWS account
    /// because it is scoped to the AWS account.
    progress_update_stream: []const u8,

    /// The name that was specified for the source resource.
    source_resource_name: []const u8,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .migration_task_name = "MigrationTaskName",
        .progress_update_stream = "ProgressUpdateStream",
        .source_resource_name = "SourceResourceName",
    };
};

pub const DisassociateSourceResourceOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateSourceResourceInput, options: CallOptions) !DisassociateSourceResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateSourceResourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.DisassociateSourceResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateSourceResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
