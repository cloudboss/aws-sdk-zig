const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportEncryptionConfiguration = @import("export_encryption_configuration.zig").ExportEncryptionConfiguration;
const ExportSetting = @import("export_setting.zig").ExportSetting;
const ExportStatus = @import("export_status.zig").ExportStatus;

pub const GetDataCatalogExportConfigurationInput = struct {
};

pub const GetDataCatalogExportConfigurationOutput = struct {
    /// The timestamp at which the export configuration was created.
    created_at: ?i64 = null,

    /// The encryption configuration for the exported data.
    encryption_configuration: ?ExportEncryptionConfiguration = null,

    /// The export setting for the data catalog. Valid values are `ENABLED` and
    /// `DISABLED`.
    export_setting: ?ExportSetting = null,

    /// The ARN of the S3 Tables bucket where catalog metadata is exported.
    s3_table_bucket_arn: ?[]const u8 = null,

    /// The current status of the export. Valid values are `ENABLING`, `ENABLED`,
    /// `DISABLING`, `DISABLED`, and `FAILED`.
    status: ?ExportStatus = null,

    /// The timestamp at which the export configuration was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .encryption_configuration = "EncryptionConfiguration",
        .export_setting = "ExportSetting",
        .s3_table_bucket_arn = "S3TableBucketArn",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataCatalogExportConfigurationInput, options: CallOptions) !GetDataCatalogExportConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataCatalogExportConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetDataCatalogExportConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataCatalogExportConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDataCatalogExportConfigurationOutput, body, allocator);
}
