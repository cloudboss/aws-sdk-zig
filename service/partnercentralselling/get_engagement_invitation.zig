const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EngagementMemberSummary = @import("engagement_member_summary.zig").EngagementMemberSummary;
const Payload = @import("payload.zig").Payload;
const EngagementInvitationPayloadType = @import("engagement_invitation_payload_type.zig").EngagementInvitationPayloadType;
const Receiver = @import("receiver.zig").Receiver;
const InvitationStatus = @import("invitation_status.zig").InvitationStatus;

pub const GetEngagementInvitationInput = struct {
    /// Specifies the catalog associated with the request. The field accepts values
    /// from the predefined set: `AWS` for live operations or `Sandbox` for testing
    /// environments.
    catalog: []const u8,

    /// Specifies the unique identifier for the retrieved engagement invitation.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetEngagementInvitationOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the engagement invitation.
    arn: ?[]const u8 = null,

    /// Indicates the catalog from which the engagement invitation details are
    /// retrieved. This field helps in identifying the appropriate catalog (e.g.,
    /// `AWS` or `Sandbox`) used in the request.
    catalog: []const u8,

    /// The description of the engagement associated with this invitation.
    engagement_description: ?[]const u8 = null,

    /// The identifier of the engagement associated with this invitation.This ID
    /// links the invitation to its corresponding engagement.
    engagement_id: ?[]const u8 = null,

    /// The title of the engagement invitation, summarizing the purpose or
    /// objectives of the opportunity shared by AWS.
    engagement_title: ?[]const u8 = null,

    /// A list of active members currently part of the Engagement. This array
    /// contains a maximum of 10 members, each represented by an object with the
    /// following properties.
    ///
    /// * CompanyName: The name of the member's company.
    /// * WebsiteUrl: The website URL of the member's company.
    existing_members: ?[]const EngagementMemberSummary = null,

    /// Indicates the date on which the engagement invitation will expire if not
    /// accepted by the partner.
    expiration_date: ?i64 = null,

    /// Unique identifier assigned to the engagement invitation being retrieved.
    id: []const u8,

    /// The date when the engagement invitation was sent to the partner.
    invitation_date: ?i64 = null,

    /// The message sent to the invited partner when the invitation was created.
    invitation_message: ?[]const u8 = null,

    /// Details of the engagement invitation payload, including specific data
    /// relevant to the invitation's contents, such as customer information and
    /// opportunity insights.
    payload: ?Payload = null,

    /// The type of payload contained in the engagement invitation, indicating what
    /// data or context the payload covers.
    payload_type: ?EngagementInvitationPayloadType = null,

    /// Information about the partner organization or team that received the
    /// engagement invitation, including contact details and identifiers.
    receiver: ?Receiver = null,

    /// If the engagement invitation was rejected, this field specifies the reason
    /// provided by the partner for the rejection.
    rejection_reason: ?[]const u8 = null,

    /// Specifies the AWS Account ID of the sender, which identifies the AWS team
    /// responsible for sharing the engagement invitation.
    sender_aws_account_id: ?[]const u8 = null,

    /// The name of the AWS organization or team that sent the engagement
    /// invitation.
    sender_company_name: ?[]const u8 = null,

    /// The current status of the engagement invitation.
    status: ?InvitationStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .engagement_description = "EngagementDescription",
        .engagement_id = "EngagementId",
        .engagement_title = "EngagementTitle",
        .existing_members = "ExistingMembers",
        .expiration_date = "ExpirationDate",
        .id = "Id",
        .invitation_date = "InvitationDate",
        .invitation_message = "InvitationMessage",
        .payload = "Payload",
        .payload_type = "PayloadType",
        .receiver = "Receiver",
        .rejection_reason = "RejectionReason",
        .sender_aws_account_id = "SenderAwsAccountId",
        .sender_company_name = "SenderCompanyName",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEngagementInvitationInput, options: Options) !GetEngagementInvitationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetEngagementInvitationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSPartnerCentralSelling.GetEngagementInvitation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetEngagementInvitationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEngagementInvitationOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
