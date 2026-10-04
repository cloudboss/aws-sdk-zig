const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const ExternalFilteringConfiguration = @import("external_filtering_configuration.zig").ExternalFilteringConfiguration;
const ServiceIntegrationUnion = @import("service_integration_union.zig").ServiceIntegrationUnion;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;

pub const UpdateLakeFormationIdentityCenterConfigurationInput = struct {
    /// Allows to enable or disable the IAM Identity Center connection.
    application_status: ?ApplicationStatus = null,

    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the
    /// persistent metadata store. It contains database definitions, table
    /// definitions, view
    /// definitions, and other control information to manage your Lake Formation
    /// environment.
    catalog_id: ?[]const u8 = null,

    /// A list of the account IDs of Amazon Web Services accounts of third-party
    /// applications
    /// that are allowed to access data managed by Lake Formation.
    external_filtering: ?ExternalFilteringConfiguration = null,

    /// A list of service integrations for enabling trusted identity propagation
    /// with external services such as Redshift.
    service_integrations: ?[]const ServiceIntegrationUnion = null,

    /// A list of Amazon Web Services account IDs or Amazon Web Services
    /// organization/organizational unit ARNs that
    /// are allowed to access to access data managed by Lake Formation.
    ///
    /// If the `ShareRecipients` list includes valid values, then the resource share
    /// is updated with the principals you want to have access to the resources.
    ///
    /// If the `ShareRecipients` value is null, both the list of share recipients
    /// and
    /// the resource share remain unchanged.
    ///
    /// If the `ShareRecipients` value is an empty list, then the existing share
    /// recipients list will be cleared, and the resource share will be deleted.
    share_recipients: ?[]const DataLakePrincipal = null,

    pub const json_field_names = .{
        .application_status = "ApplicationStatus",
        .catalog_id = "CatalogId",
        .external_filtering = "ExternalFiltering",
        .service_integrations = "ServiceIntegrations",
        .share_recipients = "ShareRecipients",
    };
};

pub const UpdateLakeFormationIdentityCenterConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLakeFormationIdentityCenterConfigurationInput, options: CallOptions) !UpdateLakeFormationIdentityCenterConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLakeFormationIdentityCenterConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateLakeFormationIdentityCenterConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.application_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApplicationStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.external_filtering) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExternalFiltering\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_integrations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ServiceIntegrations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.share_recipients) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ShareRecipients\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLakeFormationIdentityCenterConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateLakeFormationIdentityCenterConfigurationOutput = .{};

    return result;
}
