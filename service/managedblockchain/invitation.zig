const NetworkSummary = @import("network_summary.zig").NetworkSummary;
const InvitationStatus = @import("invitation_status.zig").InvitationStatus;

/// An invitation to an Amazon Web Services account to create a member and join
/// the network.
///
/// Applies only to Hyperledger Fabric.
pub const Invitation = struct {
    /// The Amazon Resource Name (ARN) of the invitation. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8,

    /// The date and time that the invitation was created.
    creation_date: ?i64,

    /// The date and time that the invitation expires. This is the `CreationDate`
    /// plus the `ProposalDurationInHours` that is specified in the
    /// `ProposalThresholdPolicy`. After this date and time, the invitee can no
    /// longer create a member and join the network using this `InvitationId`.
    expiration_date: ?i64,

    /// The unique identifier for the invitation.
    invitation_id: ?[]const u8,

    network_summary: ?NetworkSummary,

    /// The status of the invitation:
    ///
    /// * `PENDING` - The invitee hasn't created a member to join the network, and
    ///   the invitation hasn't yet expired.
    ///
    /// * `ACCEPTING` - The invitee has begun creating a member, and creation hasn't
    ///   yet completed.
    ///
    /// * `ACCEPTED` - The invitee created a member and joined the network using the
    ///   `InvitationID`.
    ///
    /// * `REJECTED` - The invitee rejected the invitation.
    ///
    /// * `EXPIRED` - The invitee neither created a member nor rejected the
    ///   invitation before the `ExpirationDate`.
    status: ?InvitationStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .expiration_date = "ExpirationDate",
        .invitation_id = "InvitationId",
        .network_summary = "NetworkSummary",
        .status = "Status",
    };
};
