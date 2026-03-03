const aws = @import("aws");

const DatasourcePackageIngestState = @import("datasource_package_ingest_state.zig").DatasourcePackageIngestState;
const MemberDisabledReason = @import("member_disabled_reason.zig").MemberDisabledReason;
const InvitationType = @import("invitation_type.zig").InvitationType;
const MemberStatus = @import("member_status.zig").MemberStatus;
const DatasourcePackageUsageInfo = @import("datasource_package_usage_info.zig").DatasourcePackageUsageInfo;

/// Details about a member account in a behavior graph.
pub const MemberDetail = struct {
    /// The Amazon Web Services account identifier for the member account.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services account identifier of the administrator account for
    /// the behavior
    /// graph.
    administrator_id: ?[]const u8 = null,

    /// The state of a data source package for the behavior graph.
    datasource_package_ingest_states: ?[]const aws.map.MapEntry(DatasourcePackageIngestState) = null,

    /// For member accounts with a status of `ACCEPTED_BUT_DISABLED`, the reason
    /// that
    /// the member account is not enabled.
    ///
    /// The reason can have one of the following values:
    ///
    /// * `VOLUME_TOO_HIGH` - Indicates that adding the member account would
    /// cause the data volume for the behavior graph to be too high.
    ///
    /// * `VOLUME_UNKNOWN` - Indicates that Detective is unable to
    /// verify the data volume for the member account. This is usually because the
    /// member
    /// account is not enrolled in Amazon GuardDuty.
    disabled_reason: ?MemberDisabledReason = null,

    /// The Amazon Web Services account root user email address for the member
    /// account.
    email_address: ?[]const u8 = null,

    /// The ARN of the behavior graph.
    graph_arn: ?[]const u8 = null,

    /// The type of behavior graph membership.
    ///
    /// For an organization account in the organization behavior graph, the type is
    /// `ORGANIZATION`.
    ///
    /// For an account that was invited to a behavior graph, the type is
    /// `INVITATION`.
    invitation_type: ?InvitationType = null,

    /// For invited accounts, the date and time that Detective sent the invitation
    /// to
    /// the account. The value is an ISO8601 formatted string. For example,
    /// `2021-08-18T16:35:56.284Z`.
    invited_time: ?i64 = null,

    /// The Amazon Web Services account identifier of the administrator account for
    /// the behavior
    /// graph.
    master_id: ?[]const u8 = null,

    /// The member account data volume as a percentage of the maximum allowed data
    /// volume. 0
    /// indicates 0 percent, and 100 indicates 100 percent.
    ///
    /// Note that this is not the percentage of the behavior graph data volume.
    ///
    /// For example, the data volume for the behavior graph is 80 GB per day. The
    /// maximum data
    /// volume is 160 GB per day. If the data volume for the member account is 40 GB
    /// per day, then
    /// `PercentOfGraphUtilization` is 25. It represents 25% of the maximum allowed
    /// data volume.
    percent_of_graph_utilization: ?f64 = null,

    /// The date and time when the graph utilization percentage was last updated.
    /// The value is
    /// an ISO8601 formatted string. For example, `2021-08-18T16:35:56.284Z`.
    percent_of_graph_utilization_updated_time: ?i64 = null,

    /// The current membership status of the member account. The status can have one
    /// of the
    /// following values:
    ///
    /// * `INVITED` - For invited accounts only. Indicates that the member was
    /// sent an invitation but has not yet responded.
    ///
    /// * `VERIFICATION_IN_PROGRESS` - For invited accounts only, indicates that
    /// Detective is verifying that the account identifier and email address
    /// provided for the member account match. If they do match, then Detective
    /// sends the invitation. If the email address and account identifier don't
    /// match, then
    /// the member cannot be added to the behavior graph.
    ///
    /// For organization accounts in the organization behavior graph, indicates that
    /// Detective is verifying that the account belongs to the
    /// organization.
    ///
    /// * `VERIFICATION_FAILED` - For invited accounts only. Indicates that the
    /// account and email address provided for the member account do not match, and
    /// Detective did not send an invitation to the account.
    ///
    /// * `ENABLED` - Indicates that the member account currently contributes
    /// data to the behavior graph. For invited accounts, the member account
    /// accepted the
    /// invitation. For organization accounts in the organization behavior graph,
    /// the Detective administrator account enabled the organization account as a
    /// member
    /// account.
    ///
    /// * `ACCEPTED_BUT_DISABLED` - The account accepted the invitation, or was
    /// enabled by the Detective administrator account, but is prevented from
    /// contributing data to the behavior graph. `DisabledReason` provides the
    /// reason why the member account is not enabled.
    ///
    /// Invited accounts that declined an invitation or that were removed from the
    /// behavior
    /// graph are not included. In the organization behavior graph, organization
    /// accounts that the
    /// Detective administrator account did not enable are not included.
    status: ?MemberStatus = null,

    /// The date and time that the member account was last updated. The value is an
    /// ISO8601
    /// formatted string. For example, `2021-08-18T16:35:56.284Z`.
    updated_time: ?i64 = null,

    /// Details on the volume of usage for each data source package in a behavior
    /// graph.
    volume_usage_by_datasource_package: ?[]const aws.map.MapEntry(DatasourcePackageUsageInfo) = null,

    /// The data volume in bytes per day for the member account.
    volume_usage_in_bytes: ?i64 = null,

    /// The data and time when the member account data volume was last updated. The
    /// value is an
    /// ISO8601 formatted string. For example, `2021-08-18T16:35:56.284Z`.
    volume_usage_updated_time: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .administrator_id = "AdministratorId",
        .datasource_package_ingest_states = "DatasourcePackageIngestStates",
        .disabled_reason = "DisabledReason",
        .email_address = "EmailAddress",
        .graph_arn = "GraphArn",
        .invitation_type = "InvitationType",
        .invited_time = "InvitedTime",
        .master_id = "MasterId",
        .percent_of_graph_utilization = "PercentOfGraphUtilization",
        .percent_of_graph_utilization_updated_time = "PercentOfGraphUtilizationUpdatedTime",
        .status = "Status",
        .updated_time = "UpdatedTime",
        .volume_usage_by_datasource_package = "VolumeUsageByDatasourcePackage",
        .volume_usage_in_bytes = "VolumeUsageInBytes",
        .volume_usage_updated_time = "VolumeUsageUpdatedTime",
    };
};
