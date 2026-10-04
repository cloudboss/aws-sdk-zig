const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppConfig = @import("app_config.zig").AppConfig;
const DataSource = @import("data_source.zig").DataSource;
const IamIdentityCenterOptions = @import("iam_identity_center_options.zig").IamIdentityCenterOptions;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

pub const GetApplicationInput = struct {
    /// The unique identifier of the OpenSearch application to retrieve.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetApplicationOutput = struct {
    /// The configuration settings of the OpenSearch application.
    app_configs: ?[]const AppConfig = null,

    arn: ?[]const u8 = null,

    /// The timestamp when the OpenSearch application was created.
    created_at: ?i64 = null,

    /// The data sources associated with the OpenSearch application.
    data_sources: ?[]const DataSource = null,

    /// The endpoint URL of the OpenSearch application.
    endpoint: ?[]const u8 = null,

    /// The IAM Identity Center settings configured for the OpenSearch application.
    iam_identity_center_options: ?IamIdentityCenterOptions = null,

    /// The unique identifier of the OpenSearch application.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the
    /// application's data at rest.
    kms_key_arn: ?[]const u8 = null,

    /// The timestamp of the last update to the OpenSearch application.
    last_updated_at: ?i64 = null,

    /// The name of the OpenSearch application.
    name: ?[]const u8 = null,

    /// The current status of the OpenSearch application. Possible values:
    /// `CREATING`,
    /// `UPDATING`, `DELETING`, `FAILED`, `ACTIVE`, and
    /// `DELETED`.
    status: ?ApplicationStatus = null,

    pub const json_field_names = .{
        .app_configs = "appConfigs",
        .arn = "arn",
        .created_at = "createdAt",
        .data_sources = "dataSources",
        .endpoint = "endpoint",
        .iam_identity_center_options = "iamIdentityCenterOptions",
        .id = "id",
        .kms_key_arn = "kmsKeyArn",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/application/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
