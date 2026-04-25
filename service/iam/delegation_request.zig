const DelegationPermission = @import("delegation_permission.zig").DelegationPermission;
const stateType = @import("state_type.zig").stateType;

/// Contains information about a delegation request, including its status,
/// permissions, and associated metadata.
pub const DelegationRequest = struct {
    approver_id: ?[]const u8 = null,

    /// Creation date (timestamp) of this delegation request.
    create_date: ?i64 = null,

    /// The unique identifier for the delegation request.
    delegation_request_id: ?[]const u8 = null,

    /// Description of the delegation request. This is a message that is provided by
    /// the Amazon Web Services
    /// partner that filed the delegation request.
    description: ?[]const u8 = null,

    /// The expiry time of this delegation request
    ///
    /// See the [Understanding the Request
    /// Lifecycle](https://docs.aws.amazon.com/IAM/latest/UserGuide/temporary-delegation-building-integration.html#temporary-delegation-request-lifecycle) for
    /// details on the life time of a delegation request at each state.
    expiration_time: ?i64 = null,

    /// Notes added to this delegation request, if this request was updated via the
    /// [UpdateDelegationRequest](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateDelegationRequest.html)
    /// API.
    notes: ?[]const u8 = null,

    /// A flag indicating whether the
    /// [SendDelegationToken](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SendDelegationToken.html)
    /// must be called by the owner of this delegation request. This is set by the
    /// requesting partner.
    only_send_by_owner: bool = false,

    /// Amazon Web Services account ID of the owner of the delegation request.
    owner_account_id: ?[]const u8 = null,

    /// ARN of the owner of this delegation request.
    owner_id: ?[]const u8 = null,

    /// JSON content of the associated permission policy of this delegation request.
    permission_policy: ?[]const u8 = null,

    permissions: ?DelegationPermission = null,

    /// A URL to be redirected to once the delegation request is approved. Partners
    /// provide this URL when
    /// creating the delegation request.
    redirect_url: ?[]const u8 = null,

    /// Reasons for rejecting this delegation request, if this request was rejected.
    /// See also
    /// [RejectDelegationRequest](https://docs.aws.amazon.com/IAM/latest/APIReference/API_RejectDelegationRequest.html)
    /// API documentation.
    rejection_reason: ?[]const u8 = null,

    /// A custom message that is added to the delegation request by the partner.
    ///
    /// This element is different from the `Description` element such that this is a
    /// request specific message injected by the partner. The `Description` is
    /// typically
    /// a generic explanation of what the delegation request is targeted to do.
    request_message: ?[]const u8 = null,

    /// Identity of the requestor of this delegation request. This will be an Amazon
    /// Web Services account ID.
    requestor_id: ?[]const u8 = null,

    /// A friendly name of the requestor.
    requestor_name: ?[]const u8 = null,

    /// If the `PermissionPolicy` includes role creation permissions, this element
    /// will
    /// include the list of permissions boundary policies associated with the role
    /// creation.
    /// See [Permissions boundaries for IAM
    /// entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html)
    /// for more details about IAM permission boundaries.
    role_permission_restriction_arns: ?[]const []const u8 = null,

    /// The life-time of the requested session credential.
    session_duration: ?i32 = null,

    /// The state of this delegation request.
    ///
    /// See the [Understanding the Request
    /// Lifecycle](https://docs.aws.amazon.com/IAM/latest/UserGuide/temporary-delegation-building-integration.html#temporary-delegation-request-lifecycle) for an explanation of how these
    /// states are transitioned.
    state: ?stateType = null,

    /// Last updated timestamp of the request.
    updated_time: ?i64 = null,
};
