const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartSchemaExtensionInput = struct {
    /// If true, creates a snapshot of the directory before applying the schema
    /// extension.
    create_snapshot_before_schema_extension: ?bool = null,

    /// A description of the schema extension.
    description: []const u8,

    /// The identifier of the directory for which the schema extension will be
    /// applied
    /// to.
    directory_id: []const u8,

    /// The LDIF file represented as a string. To construct the LdifContent string,
    /// precede
    /// each line as it would be formatted in an ldif file with \n. See the example
    /// request below for
    /// more details. The file size can be no larger than 1MB.
    ldif_content: []const u8,

    pub const json_field_names = .{
        .create_snapshot_before_schema_extension = "CreateSnapshotBeforeSchemaExtension",
        .description = "Description",
        .directory_id = "DirectoryId",
        .ldif_content = "LdifContent",
    };
};

pub const StartSchemaExtensionOutput = struct {
    /// The identifier of the schema extension that will be applied.
    schema_extension_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .schema_extension_id = "SchemaExtensionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSchemaExtensionInput, options: CallOptions) !StartSchemaExtensionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSchemaExtensionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.StartSchemaExtension");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSchemaExtensionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartSchemaExtensionOutput, body, allocator);
}
