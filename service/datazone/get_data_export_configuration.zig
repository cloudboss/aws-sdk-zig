const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

pub const GetDataExportConfigurationInput = struct {
    /// The ID of the domain where you want to get the data export configuration
    /// details.
    domain_identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
    };
};

pub const GetDataExportConfigurationOutput = struct {
    /// The timestamp at which the data export configuration report was created.
    created_at: ?i64 = null,

    /// The encryption configuration as part of the data export configuration
    /// details.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Specifies whether the export is enabled.
    is_export_enabled: ?bool = null,

    /// The Amazon S3 table bucket ARN as part of the data export configuration
    /// details.
    s_3_table_bucket_arn: ?[]const u8 = null,

    /// The status of the data export configuration.
    status: ?ConfigurationStatus = null,

    /// The timestamp at which the data export configuration report was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .encryption_configuration = "encryptionConfiguration",
        .is_export_enabled = "isExportEnabled",
        .s_3_table_bucket_arn = "s3TableBucketArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataExportConfigurationInput, options: CallOptions) !GetDataExportConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataExportConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-export-configuration");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataExportConfigurationOutput {
    const result: GetDataExportConfigurationOutput = try aws.json.parseJsonObject(
        GetDataExportConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
