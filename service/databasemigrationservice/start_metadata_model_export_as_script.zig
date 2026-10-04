const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OriginTypeValue = @import("origin_type_value.zig").OriginTypeValue;

pub const StartMetadataModelExportAsScriptInput = struct {
    /// The name for the exported file. When you omit this parameter, the service
    /// generates
    /// a name from the data provider engine name and an export timestamp.
    file_name: ?[]const u8 = null,

    /// The migration project name or Amazon Resource Name (ARN).
    migration_project_identifier: []const u8,

    /// Specifies the metadata tree to export from.
    origin: OriginTypeValue,

    /// A JSON string that identifies the metadata models to export as a SQL script.
    /// For the selection rule format and examples, see [Selection rules in DMS
    /// Schema
    /// Conversion](https://docs.aws.amazon.com/dms/latest/userguide/sc-selection-rules.html).
    ///
    /// Usage:
    ///
    /// * Accepts source or target selection rules depending on the `Origin`
    ///   parameter. The `server-name` in the object locator must match the
    ///   corresponding data provider.
    ///
    /// * Supports `explicit`, `include`, and `exclude` rule actions.
    selection_rules: []const u8,

    pub const json_field_names = .{
        .file_name = "FileName",
        .migration_project_identifier = "MigrationProjectIdentifier",
        .origin = "Origin",
        .selection_rules = "SelectionRules",
    };
};

pub const StartMetadataModelExportAsScriptOutput = struct {
    /// The identifier for the export request.
    request_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .request_identifier = "RequestIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMetadataModelExportAsScriptInput, options: CallOptions) !StartMetadataModelExportAsScriptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMetadataModelExportAsScriptInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.StartMetadataModelExportAsScript");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMetadataModelExportAsScriptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMetadataModelExportAsScriptOutput, body, allocator);
}
