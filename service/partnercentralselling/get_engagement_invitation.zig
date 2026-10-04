const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEngagementInvitationInput, options: CallOptions) !GetEngagementInvitationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEngagementInvitationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.GetEngagementInvitation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEngagementInvitationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEngagementInvitationOutput, body, allocator);
}
