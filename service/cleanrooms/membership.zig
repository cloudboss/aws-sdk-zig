const MembershipProtectedJobResultConfiguration = @import("membership_protected_job_result_configuration.zig").MembershipProtectedJobResultConfiguration;
const MembershipProtectedQueryResultConfiguration = @import("membership_protected_query_result_configuration.zig").MembershipProtectedQueryResultConfiguration;
const MembershipJobLogStatus = @import("membership_job_log_status.zig").MembershipJobLogStatus;
const MemberAbility = @import("member_ability.zig").MemberAbility;
const MLMemberAbilities = @import("ml_member_abilities.zig").MLMemberAbilities;
const MembershipPaymentConfiguration = @import("membership_payment_configuration.zig").MembershipPaymentConfiguration;
const MembershipQueryLogStatus = @import("membership_query_log_status.zig").MembershipQueryLogStatus;
const MembershipStatus = @import("membership_status.zig").MembershipStatus;

/// The membership object.
pub const Membership = struct {
    /// The unique ARN for the membership.
    arn: []const u8,

    /// The unique ARN for the membership's associated collaboration.
    collaboration_arn: []const u8,

    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    collaboration_creator_account_id: []const u8,

    /// The display name of the collaboration creator.
    collaboration_creator_display_name: []const u8,

    /// The unique ID for the membership's collaboration.
    collaboration_id: []const u8,

    /// The name of the membership's collaboration.
    collaboration_name: []const u8,

    /// The time when the membership was created.
    create_time: i64,

    /// The default job result configuration for the membership.
    default_job_result_configuration: ?MembershipProtectedJobResultConfiguration = null,

    /// The default protected query result configuration as specified by the member
    /// who can receive results.
    default_result_configuration: ?MembershipProtectedQueryResultConfiguration = null,

    /// The unique ID of the membership.
    id: []const u8,

    /// An indicator as to whether Amazon CloudWatch metrics are enabled for the
    /// membership.
    ///
    /// When `true`, metrics about query execution are collected in Amazon
    /// CloudWatch.
    is_metrics_enabled: ?bool = null,

    /// An indicator as to whether job logging has been enabled or disabled for the
    /// collaboration.
    ///
    /// When `ENABLED`, Clean Rooms logs details about jobs run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    job_log_status: ?MembershipJobLogStatus = null,

    /// The abilities granted to the collaboration member.
    member_abilities: []const MemberAbility,

    /// Specifies the ML member abilities that are granted to a collaboration
    /// member.
    ml_member_abilities: ?MLMemberAbilities = null,

    /// The payment responsibilities accepted by the collaboration member.
    payment_configuration: MembershipPaymentConfiguration,

    /// An indicator as to whether query logging has been enabled or disabled for
    /// the membership.
    ///
    /// When `ENABLED`, Clean Rooms logs details about queries run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    query_log_status: MembershipQueryLogStatus,

    /// The status of the membership.
    status: MembershipStatus,

    /// The time the membership metadata was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_creator_account_id = "collaborationCreatorAccountId",
        .collaboration_creator_display_name = "collaborationCreatorDisplayName",
        .collaboration_id = "collaborationId",
        .collaboration_name = "collaborationName",
        .create_time = "createTime",
        .default_job_result_configuration = "defaultJobResultConfiguration",
        .default_result_configuration = "defaultResultConfiguration",
        .id = "id",
        .is_metrics_enabled = "isMetricsEnabled",
        .job_log_status = "jobLogStatus",
        .member_abilities = "memberAbilities",
        .ml_member_abilities = "mlMemberAbilities",
        .payment_configuration = "paymentConfiguration",
        .query_log_status = "queryLogStatus",
        .status = "status",
        .update_time = "updateTime",
    };
};
