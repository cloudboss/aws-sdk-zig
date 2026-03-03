const ResourceShareAssociation = @import("resource_share_association.zig").ResourceShareAssociation;
const ResourceShareInvitationStatus = @import("resource_share_invitation_status.zig").ResourceShareInvitationStatus;

/// Describes an invitation for an Amazon Web Services account to join a
/// resource share.
pub const ResourceShareInvitation = struct {
    /// The date and time when the invitation was sent.
    invitation_timestamp: ?i64 = null,

    /// The ID of the Amazon Web Services account that received the invitation.
    receiver_account_id: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IAM user or role that received the invitation.
    receiver_arn: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share
    resource_share_arn: ?[]const u8 = null,

    /// To view the resources associated with a pending resource share invitation,
    /// use ListPendingInvitationResources.
    resource_share_associations: ?[]const ResourceShareAssociation = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the invitation.
    resource_share_invitation_arn: ?[]const u8 = null,

    /// The name of the resource share.
    resource_share_name: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that sent the invitation.
    sender_account_id: ?[]const u8 = null,

    /// The current status of the invitation.
    status: ?ResourceShareInvitationStatus = null,

    pub const json_field_names = .{
        .invitation_timestamp = "invitationTimestamp",
        .receiver_account_id = "receiverAccountId",
        .receiver_arn = "receiverArn",
        .resource_share_arn = "resourceShareArn",
        .resource_share_associations = "resourceShareAssociations",
        .resource_share_invitation_arn = "resourceShareInvitationArn",
        .resource_share_name = "resourceShareName",
        .sender_account_id = "senderAccountId",
        .status = "status",
    };
};
