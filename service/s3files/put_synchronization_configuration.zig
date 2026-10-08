const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpirationDataRule = @import("expiration_data_rule.zig").ExpirationDataRule;
const ImportDataRule = @import("import_data_rule.zig").ImportDataRule;

pub const PutSynchronizationConfigurationInput = struct {
    /// An array of expiration data rules that control when cached data expires from
    /// the file system.
    expiration_data_rules: []const ExpirationDataRule,

    /// The ID or Amazon Resource Name (ARN) of the S3 File System to configure
    /// synchronization for.
    file_system_id: []const u8,

    /// An array of import data rules that control how data is imported from S3 into
    /// the file system.
    import_data_rules: []const ImportDataRule,

    /// The version number of the current synchronization configuration. Omit this
    /// value when creating a synchronization configuration for the first time. For
    /// subsequent updates, provide this value for optimistic concurrency control.
    /// If the version number does not match the current configuration, the request
    /// fails with a `ConflictException`.
    latest_version_number: ?i32 = null,

    pub const json_field_names = .{
        .expiration_data_rules = "expirationDataRules",
        .file_system_id = "fileSystemId",
        .import_data_rules = "importDataRules",
        .latest_version_number = "latestVersionNumber",
    };
};

pub const PutSynchronizationConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSynchronizationConfigurationInput, options: CallOptions) !PutSynchronizationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSynchronizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    try path_buf.appendSlice(allocator, "/synchronization-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"expirationDataRules\":");
    try aws.json.writeValue(@TypeOf(input.expiration_data_rules), input.expiration_data_rules, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"importDataRules\":");
    try aws.json.writeValue(@TypeOf(input.import_data_rules), input.import_data_rules, allocator, &body_buf);
    has_prev = true;
    if (input.latest_version_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"latestVersionNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSynchronizationConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutSynchronizationConfigurationOutput = .{};

    return result;
}
