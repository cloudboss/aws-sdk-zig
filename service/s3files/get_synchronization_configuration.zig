const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpirationDataRule = @import("expiration_data_rule.zig").ExpirationDataRule;
const ImportDataRule = @import("import_data_rule.zig").ImportDataRule;

pub const GetSynchronizationConfigurationInput = struct {
    /// The ID or Amazon Resource Name (ARN) of the S3 File System to retrieve the
    /// synchronization configuration for.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "fileSystemId",
    };
};

pub const GetSynchronizationConfigurationOutput = struct {
    /// An array of expiration data rules that control when cached data expires from
    /// the file system.
    expiration_data_rules: ?[]const ExpirationDataRule = null,

    /// An array of import data rules that control how data is imported from S3 into
    /// the file system.
    import_data_rules: ?[]const ImportDataRule = null,

    /// The version number of the synchronization configuration. Use this value with
    /// `PutSynchronizationConfiguration` to ensure optimistic concurrency control.
    latest_version_number: ?i32 = null,

    pub const json_field_names = .{
        .expiration_data_rules = "expirationDataRules",
        .import_data_rules = "importDataRules",
        .latest_version_number = "latestVersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSynchronizationConfigurationInput, options: CallOptions) !GetSynchronizationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSynchronizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    try path_buf.appendSlice(allocator, "/synchronization-configuration");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSynchronizationConfigurationOutput {
    const result: GetSynchronizationConfigurationOutput = try aws.json.parseJsonObject(
        GetSynchronizationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
