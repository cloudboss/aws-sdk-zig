const ParticipantType = @import("participant_type.zig").ParticipantType;
const EngagementInvitationPayloadType = @import("engagement_invitation_payload_type.zig").EngagementInvitationPayloadType;
const Receiver = @import("receiver.zig").Receiver;
const InvitationStatus = @import("invitation_status.zig").InvitationStatus;

/// Provides a summarized view of the Engagement Invitation, including details
/// like the identifier, status, and sender. This summary helps partners track
/// and manage AWS originated opportunities.
pub const EngagementInvitationSummary = struct {
    /// The Amazon Resource Name (ARN) of the Engagement Invitation. The ARN is a
    /// unique identifier that allows partners to reference the invitation in their
    /// system and manage its lifecycle.
    arn: ?[]const u8,

    /// Specifies the catalog in which the Engagement Invitation resides. This can
    /// be either the `AWS` or `Sandbox` catalog, indicating whether the opportunity
    /// is live or being tested.
    catalog: []const u8,

    /// The identifier of the Engagement associated with this invitation. This links
    /// the invitation to its parent Engagement.
    engagement_id: ?[]const u8,

    /// Provides a short title or description of the Engagement Invitation. This
    /// title helps partners quickly identify and differentiate between multiple
    /// engagement opportunities.
    engagement_title: ?[]const u8,

    /// Indicates the date and time when the Engagement Invitation will expire.
    /// After this date, the invitation can no longer be accepted, and the
    /// opportunity will be unavailable to the partner.
    expiration_date: ?i64,

    /// Represents the unique identifier of the Engagement Invitation. This
    /// identifier is used to track the invitation and to manage responses like
    /// acceptance or rejection.
    id: []const u8,

    /// Indicates the date when the Engagement Invitation was sent to the partner.
    /// This provides context for when the opportunity was shared and helps in
    /// tracking the timeline for engagement.
    invitation_date: ?i64,

    /// Identifies the role of the caller in the engagement invitation.
    participant_type: ?ParticipantType,

    /// Describes the type of payload associated with the Engagement Invitation,
    /// such as `Opportunity` or `MarketplaceOffer`. This helps partners understand
    /// the nature of the engagement request from AWS.
    payload_type: ?EngagementInvitationPayloadType,

    /// Specifies the partner company or individual that received the Engagement
    /// Invitation. This field is important for tracking who the invitation was sent
    /// to within the partner organization.
    receiver: ?Receiver,

    /// Specifies the AWS account ID of the sender who initiated the Engagement
    /// Invitation. This allows the partner to identify the AWS entity or
    /// representative responsible for sharing the opportunity.
    sender_aws_account_id: ?[]const u8,

    /// Indicates the name of the company or AWS division that sent the Engagement
    /// Invitation. This information is useful for partners to know which part of
    /// AWS is requesting engagement.
    sender_company_name: ?[]const u8,

    /// Represents the current status of the Engagement Invitation, such as
    /// `Pending`, `Accepted`, or `Rejected`. The status helps track the progress
    /// and response to the invitation.
    status: ?InvitationStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .engagement_id = "EngagementId",
        .engagement_title = "EngagementTitle",
        .expiration_date = "ExpirationDate",
        .id = "Id",
        .invitation_date = "InvitationDate",
        .participant_type = "ParticipantType",
        .payload_type = "PayloadType",
        .receiver = "Receiver",
        .sender_aws_account_id = "SenderAwsAccountId",
        .sender_company_name = "SenderCompanyName",
        .status = "Status",
    };
};
