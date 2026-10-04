const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteProgress = @import("delete_progress.zig").DeleteProgress;
const DomainVersion = @import("domain_version.zig").DomainVersion;
const FailureReason = @import("failure_reason.zig").FailureReason;
const SingleSignOn = @import("single_sign_on.zig").SingleSignOn;
const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const GetDomainInput = struct {
    /// The identifier of the specified Amazon DataZone domain.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetDomainOutput = struct {
    /// The ARN of the specified Amazon DataZone domain.
    arn: ?[]const u8 = null,

    /// The timestamp of when the Amazon DataZone domain was created.
    created_at: ?i64 = null,

    /// The progress of the current domain deletion, including the number of
    /// projects that Amazon DataZone successfully deleted.
    delete_progress: ?DeleteProgress = null,

    /// The description of the Amazon DataZone domain.
    description: ?[]const u8 = null,

    /// The domain execution role with which the Amazon DataZone domain is created.
    domain_execution_role: []const u8,

    /// The version of the domain.
    domain_version: ?DomainVersion = null,

    /// The list of failure reasons for resources that Amazon DataZone could not
    /// delete during a cascade deletion of the domain.
    failure_reasons: ?[]const FailureReason = null,

    /// The identifier of the specified Amazon DataZone domain.
    id: []const u8,

    /// The identifier of the Amazon Web Services Key Management Service (KMS) key
    /// that is used to encrypt the Amazon DataZone domain, metadata, and reporting
    /// data.
    kms_key_identifier: ?[]const u8 = null,

    /// The timestamp of when the Amazon DataZone domain was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the Amazon DataZone domain.
    name: ?[]const u8 = null,

    /// The URL of the data portal for this Amazon DataZone domain.
    portal_url: ?[]const u8 = null,

    /// The ID of the root domain in Amazon Datazone.
    root_domain_unit_id: ?[]const u8 = null,

    /// The service role of the domain.
    service_role: ?[]const u8 = null,

    /// The single sing-on option of the specified Amazon DataZone domain.
    single_sign_on: ?SingleSignOn = null,

    /// The status of the specified Amazon DataZone domain.
    status: DomainStatus,

    /// The tags specified for the Amazon DataZone domain.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .delete_progress = "deleteProgress",
        .description = "description",
        .domain_execution_role = "domainExecutionRole",
        .domain_version = "domainVersion",
        .failure_reasons = "failureReasons",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .portal_url = "portalUrl",
        .root_domain_unit_id = "rootDomainUnitId",
        .service_role = "serviceRole",
        .single_sign_on = "singleSignOn",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainInput, options: CallOptions) !GetDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainOutput {
    const result: GetDomainOutput = try aws.json.parseJsonObject(
        GetDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
