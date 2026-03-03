const ActionCompletionStrategy = @import("action_completion_strategy.zig").ActionCompletionStrategy;
const AdditionalSecurityRequirement = @import("additional_security_requirement.zig").AdditionalSecurityRequirement;
const SessionStatus = @import("session_status.zig").SessionStatus;
const SessionStatusCode = @import("session_status_code.zig").SessionStatusCode;

/// Contains details for an approval session. For more information, see
/// [Session](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html)
/// in the *Multi-party approval User Guide*
pub const ListSessionsResponseSession = struct {
    /// Strategy for executing the protected operation.
    /// `AUTO_COMPLETION_UPON_APPROVAL` means the operation is executed
    /// automatically using the requester's permissions, if approved.
    action_completion_strategy: ?ActionCompletionStrategy = null,

    /// Name of the protected operation.
    action_name: ?[]const u8 = null,

    /// A list of `AdditionalSecurityRequirement` applied to the session.
    additional_security_requirements: ?[]const AdditionalSecurityRequirement = null,

    /// Amazon Resource Name (ARN) for the approval team.
    approval_team_arn: ?[]const u8 = null,

    /// Name of the approval team.
    approval_team_name: ?[]const u8 = null,

    /// Timestamp when the session was completed.
    completion_time: ?i64 = null,

    /// Description for the team.
    description: ?[]const u8 = null,

    /// Timestamp when the session was expire.
    expiration_time: ?i64 = null,

    /// Timestamp when the session was initiated.
    initiation_time: ?i64 = null,

    /// Amazon Resource Name (ARN) for the protected operation.
    protected_resource_arn: ?[]const u8 = null,

    /// ID for the account that made the operation request.
    requester_account_id: ?[]const u8 = null,

    /// [IAM
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-request) that made the operation request.
    requester_principal_arn: ?[]const u8 = null,

    /// Amazon Web Services Region where the operation request originated.
    requester_region: ?[]const u8 = null,

    /// [Service
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#principal-services) for the service associated with the protected operation.
    requester_service_principal: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the session.
    session_arn: ?[]const u8 = null,

    /// Status for the protected operation. For example, if the operation is
    /// `PENDING`.
    status: ?SessionStatus = null,

    /// Status code of the session.
    status_code: ?SessionStatusCode = null,

    /// Message describing the status for session.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_completion_strategy = "ActionCompletionStrategy",
        .action_name = "ActionName",
        .additional_security_requirements = "AdditionalSecurityRequirements",
        .approval_team_arn = "ApprovalTeamArn",
        .approval_team_name = "ApprovalTeamName",
        .completion_time = "CompletionTime",
        .description = "Description",
        .expiration_time = "ExpirationTime",
        .initiation_time = "InitiationTime",
        .protected_resource_arn = "ProtectedResourceArn",
        .requester_account_id = "RequesterAccountId",
        .requester_principal_arn = "RequesterPrincipalArn",
        .requester_region = "RequesterRegion",
        .requester_service_principal = "RequesterServicePrincipal",
        .session_arn = "SessionArn",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
    };
};
