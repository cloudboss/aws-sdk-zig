const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportEncryptionConfiguration = @import("export_encryption_configuration.zig").ExportEncryptionConfiguration;
const ExportSetting = @import("export_setting.zig").ExportSetting;

pub const PutDataCatalogExportConfigurationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The encryption configuration for the exported data. If not specified, the
    /// default encryption settings are used.
    encryption_configuration: ?ExportEncryptionConfiguration = null,

    /// The export setting for the data catalog. Specify `ENABLED` to start
    /// exporting catalog metadata to S3 Tables, or `DISABLED` to stop exporting.
    /// This field is required.
    export_setting: ExportSetting,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .encryption_configuration = "EncryptionConfiguration",
        .export_setting = "ExportSetting",
    };
};

pub const PutDataCatalogExportConfigurationOutput = struct {
    /// The encryption configuration for the exported data.
    encryption_configuration: ?ExportEncryptionConfiguration = null,

    /// The export setting for the data catalog.
    export_setting: ?ExportSetting = null,

    pub const json_field_names = .{
        .encryption_configuration = "EncryptionConfiguration",
        .export_setting = "ExportSetting",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDataCatalogExportConfigurationInput, options: CallOptions) !PutDataCatalogExportConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDataCatalogExportConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PutDataCatalogExportConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDataCatalogExportConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutDataCatalogExportConfigurationOutput, body, allocator);
}
