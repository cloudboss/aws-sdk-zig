const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartMetadataModelExportToTargetInput = struct {
    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// Whether to overwrite the migration project extension pack. An extension pack
    /// is an add-on module
    /// that emulates functions present in a source database that are required when
    /// converting objects
    /// to the target database.
    overwrite_extension_pack: ?bool = null,

    /// A value that specifies the database objects to export.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .migration_project_identifier = "MigrationProjectIdentifier",
        .overwrite_extension_pack = "OverwriteExtensionPack",
        .selection_rules = "SelectionRules",
    };
};

pub const StartMetadataModelExportToTargetOutput = struct {
    /// The identifier for the export operation.
    request_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .request_identifier = "RequestIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMetadataModelExportToTargetInput, options: CallOptions) !StartMetadataModelExportToTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMetadataModelExportToTargetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.StartMetadataModelExportToTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMetadataModelExportToTargetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMetadataModelExportToTargetOutput, body, allocator);
}
