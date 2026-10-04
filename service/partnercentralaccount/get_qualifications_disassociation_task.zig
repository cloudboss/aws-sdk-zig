const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QualificationsAssociationPartner = @import("qualifications_association_partner.zig").QualificationsAssociationPartner;
const QualificationsDisassociationTaskStatus = @import("qualifications_disassociation_task_status.zig").QualificationsDisassociationTaskStatus;

pub const GetQualificationsDisassociationTaskInput = struct {
    /// The catalog in which to look up the qualifications disassociation task.
    /// Valid values: `AWS`, `Sandbox`.
    catalog: []const u8,

    /// Your partner identifier. You can provide either a partner ID (for example,
    /// `partner-abc123`) or a partner ARN. You must own this identifier.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetQualificationsDisassociationTaskOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies your partner
    /// resource.
    arn: []const u8,

    /// The primary partner's profile and account identifiers that the task is
    /// disassociating qualifications from.
    associated_partner: ?QualificationsAssociationPartner = null,

    /// The catalog identifier echoed from the request.
    catalog: []const u8,

    /// The timestamp when the qualifications disassociation task ended, in ISO 8601
    /// format. This field is present only when the status is `SUCCEEDED`.
    ended_at: ?i64 = null,

    /// Your unique partner identifier in the AWS Partner Network.
    id: []const u8,

    /// The timestamp when the qualifications disassociation task started, in ISO
    /// 8601 format.
    started_at: i64,

    /// The current status of the qualifications disassociation task. Valid values:
    /// `IN_PROGRESS`, `SUCCEEDED`.
    status: QualificationsDisassociationTaskStatus,

    /// The unique identifier of the qualifications disassociation task, in the
    /// format `pqdtask-[a-z2-7]{13}`.
    task_id: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_partner = "AssociatedPartner",
        .catalog = "Catalog",
        .ended_at = "EndedAt",
        .id = "Id",
        .started_at = "StartedAt",
        .status = "Status",
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQualificationsDisassociationTaskInput, options: CallOptions) !GetQualificationsDisassociationTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQualificationsDisassociationTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.GetQualificationsDisassociationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQualificationsDisassociationTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetQualificationsDisassociationTaskOutput, body, allocator);
}
