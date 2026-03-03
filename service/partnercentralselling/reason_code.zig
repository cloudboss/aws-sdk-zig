const std = @import("std");

pub const ReasonCode = enum {
    invitation_access_denied,
    invitation_validation_failed,
    engagement_access_denied,
    opportunity_access_denied,
    resource_snapshot_job_access_denied,
    resource_snapshot_job_validation_failed,
    resource_snapshot_job_conflict,
    engagement_validation_failed,
    engagement_conflict,
    opportunity_submission_failed,
    engagement_invitation_conflict,
    internal_error,
    opportunity_validation_failed,
    opportunity_conflict,
    resource_snapshot_access_denied,
    resource_snapshot_validation_failed,
    resource_snapshot_conflict,
    service_quota_exceeded,
    request_throttled,
    context_not_found,
    customer_project_context_not_permitted,
    disqualified_lead_not_permitted,

    pub const json_field_names = .{
        .invitation_access_denied = "InvitationAccessDenied",
        .invitation_validation_failed = "InvitationValidationFailed",
        .engagement_access_denied = "EngagementAccessDenied",
        .opportunity_access_denied = "OpportunityAccessDenied",
        .resource_snapshot_job_access_denied = "ResourceSnapshotJobAccessDenied",
        .resource_snapshot_job_validation_failed = "ResourceSnapshotJobValidationFailed",
        .resource_snapshot_job_conflict = "ResourceSnapshotJobConflict",
        .engagement_validation_failed = "EngagementValidationFailed",
        .engagement_conflict = "EngagementConflict",
        .opportunity_submission_failed = "OpportunitySubmissionFailed",
        .engagement_invitation_conflict = "EngagementInvitationConflict",
        .internal_error = "InternalError",
        .opportunity_validation_failed = "OpportunityValidationFailed",
        .opportunity_conflict = "OpportunityConflict",
        .resource_snapshot_access_denied = "ResourceSnapshotAccessDenied",
        .resource_snapshot_validation_failed = "ResourceSnapshotValidationFailed",
        .resource_snapshot_conflict = "ResourceSnapshotConflict",
        .service_quota_exceeded = "ServiceQuotaExceeded",
        .request_throttled = "RequestThrottled",
        .context_not_found = "ContextNotFound",
        .customer_project_context_not_permitted = "CustomerProjectContextNotPermitted",
        .disqualified_lead_not_permitted = "DisqualifiedLeadNotPermitted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invitation_access_denied => "InvitationAccessDenied",
            .invitation_validation_failed => "InvitationValidationFailed",
            .engagement_access_denied => "EngagementAccessDenied",
            .opportunity_access_denied => "OpportunityAccessDenied",
            .resource_snapshot_job_access_denied => "ResourceSnapshotJobAccessDenied",
            .resource_snapshot_job_validation_failed => "ResourceSnapshotJobValidationFailed",
            .resource_snapshot_job_conflict => "ResourceSnapshotJobConflict",
            .engagement_validation_failed => "EngagementValidationFailed",
            .engagement_conflict => "EngagementConflict",
            .opportunity_submission_failed => "OpportunitySubmissionFailed",
            .engagement_invitation_conflict => "EngagementInvitationConflict",
            .internal_error => "InternalError",
            .opportunity_validation_failed => "OpportunityValidationFailed",
            .opportunity_conflict => "OpportunityConflict",
            .resource_snapshot_access_denied => "ResourceSnapshotAccessDenied",
            .resource_snapshot_validation_failed => "ResourceSnapshotValidationFailed",
            .resource_snapshot_conflict => "ResourceSnapshotConflict",
            .service_quota_exceeded => "ServiceQuotaExceeded",
            .request_throttled => "RequestThrottled",
            .context_not_found => "ContextNotFound",
            .customer_project_context_not_permitted => "CustomerProjectContextNotPermitted",
            .disqualified_lead_not_permitted => "DisqualifiedLeadNotPermitted",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
