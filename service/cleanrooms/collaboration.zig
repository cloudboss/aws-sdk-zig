const SupportedS3Region = @import("supported_s3_region.zig").SupportedS3Region;
const AnalyticsEngine = @import("analytics_engine.zig").AnalyticsEngine;
const AutoApprovedChangeType = @import("auto_approved_change_type.zig").AutoApprovedChangeType;
const DataEncryptionMetadata = @import("data_encryption_metadata.zig").DataEncryptionMetadata;
const CollaborationJobLogStatus = @import("collaboration_job_log_status.zig").CollaborationJobLogStatus;
const MemberStatus = @import("member_status.zig").MemberStatus;
const CollaborationQueryLogStatus = @import("collaboration_query_log_status.zig").CollaborationQueryLogStatus;

/// The multi-party data share environment. The collaboration contains metadata
/// about its purpose and participants.
pub const Collaboration = struct {
    /// The Amazon Web Services Regions where collaboration query results can be
    /// stored. Returns the list of Region identifiers that were specified when the
    /// collaboration was created. This list is used to enforce regional storage
    /// policies and compliance requirements.
    allowed_result_regions: ?[]const SupportedS3Region,

    /// The analytics engine for the collaboration.
    ///
    /// After July 16, 2025, the `CLEAN_ROOMS_SQL` parameter will no longer be
    /// available.
    analytics_engine: ?AnalyticsEngine,

    /// The unique ARN for the collaboration.
    arn: []const u8,

    /// The types of change requests that are automatically approved for this
    /// collaboration.
    auto_approved_change_types: ?[]const AutoApprovedChangeType,

    /// The time when the collaboration was created.
    create_time: i64,

    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    creator_account_id: []const u8,

    /// A display name of the collaboration creator.
    creator_display_name: []const u8,

    /// The settings for client-side encryption for cryptographic computing.
    data_encryption_metadata: ?DataEncryptionMetadata,

    /// A description of the collaboration provided by the collaboration owner.
    description: ?[]const u8,

    /// The unique ID for the collaboration.
    id: []const u8,

    /// An indicator as to whether metrics are enabled for the collaboration.
    ///
    /// When `true`, collaboration members can opt in to Amazon CloudWatch metrics
    /// for their membership queries.
    is_metrics_enabled: ?bool,

    /// An indicator as to whether job logging has been enabled or disabled for the
    /// collaboration.
    ///
    /// When `ENABLED`, Clean Rooms logs details about jobs run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    job_log_status: ?CollaborationJobLogStatus,

    /// The unique ARN for your membership within the collaboration.
    membership_arn: ?[]const u8,

    /// The unique ID for your membership within the collaboration.
    membership_id: ?[]const u8,

    /// The status of a member in a collaboration.
    member_status: MemberStatus,

    /// A human-readable identifier provided by the collaboration owner. Display
    /// names are not unique.
    name: []const u8,

    /// An indicator as to whether query logging has been enabled or disabled for
    /// the collaboration.
    ///
    /// When `ENABLED`, Clean Rooms logs details about queries run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    query_log_status: CollaborationQueryLogStatus,

    /// The time the collaboration metadata was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .allowed_result_regions = "allowedResultRegions",
        .analytics_engine = "analyticsEngine",
        .arn = "arn",
        .auto_approved_change_types = "autoApprovedChangeTypes",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .creator_display_name = "creatorDisplayName",
        .data_encryption_metadata = "dataEncryptionMetadata",
        .description = "description",
        .id = "id",
        .is_metrics_enabled = "isMetricsEnabled",
        .job_log_status = "jobLogStatus",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .member_status = "memberStatus",
        .name = "name",
        .query_log_status = "queryLogStatus",
        .update_time = "updateTime",
    };
};
