const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExternalFilteringConfiguration = @import("external_filtering_configuration.zig").ExternalFilteringConfiguration;
const ServiceIntegrationUnion = @import("service_integration_union.zig").ServiceIntegrationUnion;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;

pub const DescribeLakeFormationIdentityCenterConfigurationInput = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
    };
};

pub const DescribeLakeFormationIdentityCenterConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Lake Formation application integrated
    /// with IAM Identity Center.
    application_arn: ?[]const u8 = null,

    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    /// Indicates if external filtering is enabled.
    external_filtering: ?ExternalFilteringConfiguration = null,

    /// The Amazon Resource Name (ARN) of the connection.
    instance_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the RAM share.
    resource_share: ?[]const u8 = null,

    /// A list of service integrations for enabling trusted identity propagation
    /// with external services such as Redshift.
    service_integrations: ?[]const ServiceIntegrationUnion = null,

    /// A list of Amazon Web Services account IDs or Amazon Web Services
    /// organization/organizational unit ARNs that
    /// are allowed to access data managed by Lake Formation.
    ///
    /// If the `ShareRecipients` list includes valid values, a resource share is
    /// created with the principals you want to have access to the resources as the
    /// `ShareRecipients`.
    ///
    /// If the `ShareRecipients` value is null or the list is empty, no resource
    /// share is created.
    share_recipients: ?[]const DataLakePrincipal = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .catalog_id = "CatalogId",
        .external_filtering = "ExternalFiltering",
        .instance_arn = "InstanceArn",
        .resource_share = "ResourceShare",
        .service_integrations = "ServiceIntegrations",
        .share_recipients = "ShareRecipients",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLakeFormationIdentityCenterConfigurationInput, options: CallOptions) !DescribeLakeFormationIdentityCenterConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLakeFormationIdentityCenterConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DescribeLakeFormationIdentityCenterConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLakeFormationIdentityCenterConfigurationOutput {
    const result: DescribeLakeFormationIdentityCenterConfigurationOutput = try aws.json.parseJsonObject(
        DescribeLakeFormationIdentityCenterConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
