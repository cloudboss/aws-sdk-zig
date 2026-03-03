const ActionType = @import("action_type.zig").ActionType;
const HandshakeParty = @import("handshake_party.zig").HandshakeParty;
const HandshakeResource = @import("handshake_resource.zig").HandshakeResource;
const HandshakeState = @import("handshake_state.zig").HandshakeState;

/// Contains details for a handshake. A handshake is the secure exchange of
/// information
/// between two Amazon Web Services accounts: a sender and a recipient.
///
/// **Note:** Handshakes that are `CANCELED`,
/// `ACCEPTED`, `DECLINED`, or `EXPIRED` show up in
/// lists for only 30 days after entering that state After that they are
/// deleted.
pub const Handshake = struct {
    /// The type of handshake:
    ///
    /// * **INVITE**: Handshake sent to a standalone
    /// account requesting that it to join the sender's organization.
    ///
    /// * **ENABLE_ALL_FEATURES**: Handshake sent to
    /// invited member accounts to enable all features for the organization.
    ///
    /// * **APPROVE_ALL_FEATURES**: Handshake sent to the
    /// management account when all invited member accounts have approved to enable
    /// all
    /// features.
    ///
    /// * **TRANSFER_RESPONSIBILITY**: Handshake sent to
    /// another organization's management account requesting that it designate the
    /// sender with the specified responsibilities for recipient's organization.
    action: ?ActionType = null,

    /// Amazon Resource Name (ARN) for the handshake.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8 = null,

    /// Timestamp when the handshake expires.
    expiration_timestamp: ?i64 = null,

    /// ID for the handshake.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for handshake ID string
    /// requires "h-"
    /// followed by from 8 to 32 lowercase letters or digits.
    id: ?[]const u8 = null,

    /// An array of `HandshakeParty` objects. Contains details for participant in a
    /// handshake.
    parties: ?[]const HandshakeParty = null,

    /// Timestamp when the handshake request was made.
    requested_timestamp: ?i64 = null,

    /// An array of `HandshakeResource` objects. When needed, contains additional
    /// details for a handshake. For example, the email address for the sender.
    resources: ?[]const HandshakeResource = null,

    /// Current state for the handshake.
    ///
    /// * **REQUESTED**: Handshake awaiting a response from
    /// the recipient.
    ///
    /// * **OPEN**: Handshake sent to multiple recipients
    /// and all recipients have responded. The sender can now complete the handshake
    /// action.
    ///
    /// * **CANCELED**: Handshake canceled by the
    /// sender.
    ///
    /// * **ACCEPTED**: Handshake accepted by the
    /// recipient.
    ///
    /// * **DECLINED**: Handshake declined by the
    /// recipient.
    ///
    /// * **EXPIRED**: Handshake has expired.
    state: ?HandshakeState = null,

    pub const json_field_names = .{
        .action = "Action",
        .arn = "Arn",
        .expiration_timestamp = "ExpirationTimestamp",
        .id = "Id",
        .parties = "Parties",
        .requested_timestamp = "RequestedTimestamp",
        .resources = "Resources",
        .state = "State",
    };
};
