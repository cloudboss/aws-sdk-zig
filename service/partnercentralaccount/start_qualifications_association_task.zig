const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QualificationsAssociationPartner = @import("qualifications_association_partner.zig").QualificationsAssociationPartner;
const QualificationsAssociationTaskStatus = @import("qualifications_association_task_status.zig").QualificationsAssociationTaskStatus;

pub const StartQualificationsAssociationTaskInput = struct {
    /// The catalog in which to perform the qualifications association. Valid
    /// values: `AWS`, `Sandbox`.
    catalog: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// Your partner identifier. You can provide either a partner ID (for example,
    /// `partner-abc123`) or a partner ARN. You must own this identifier.
    identifier: []const u8,

    /// The primary (acquiring) partner's profile and account identifier to
    /// associate qualifications with. You must provide at least one of `ProfileId`
    /// or `AccountId`. You cannot specify yourself as the primary partner.
    primary_partner: QualificationsAssociationPartner,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .primary_partner = "PrimaryPartner",
    };
};

pub const StartQualificationsAssociationTaskOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies your partner
    /// resource.
    arn: []const u8,

    /// The catalog identifier echoed from the request.
    catalog: []const u8,

    /// Your unique partner identifier in the AWS Partner Network.
    id: []const u8,

    /// The resolved primary partner's profile and account identifiers, including
    /// both `ProfileId` and `AccountId`.
    primary_partner: ?QualificationsAssociationPartner = null,

    /// The timestamp when the qualifications association task started, in ISO 8601
    /// format.
    started_at: i64,

    /// The current status of the qualifications association task. The initial value
    /// is `IN_PROGRESS`.
    status: QualificationsAssociationTaskStatus,

    /// The unique identifier of the started qualifications association task, in the
    /// format `pqatask-[a-z2-7]{13}`.
    task_id: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .id = "Id",
        .primary_partner = "PrimaryPartner",
        .started_at = "StartedAt",
        .status = "Status",
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQualificationsAssociationTaskInput, options: CallOptions) !StartQualificationsAssociationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQualificationsAssociationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.StartQualificationsAssociationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQualificationsAssociationTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartQualificationsAssociationTaskOutput, body, allocator);
}
