const CaseStatus = @import("case_status.zig").CaseStatus;
const EngagementType = @import("engagement_type.zig").EngagementType;
const PendingAction = @import("pending_action.zig").PendingAction;
const ResolverType = @import("resolver_type.zig").ResolverType;

pub const ListCasesItem = struct {
    case_arn: ?[]const u8 = null,

    case_id: []const u8,

    case_status: ?CaseStatus = null,

    closed_date: ?i64 = null,

    created_date: ?i64 = null,

    engagement_type: ?EngagementType = null,

    last_updated_date: ?i64 = null,

    pending_action: ?PendingAction = null,

    resolver_type: ?ResolverType = null,

    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_arn = "caseArn",
        .case_id = "caseId",
        .case_status = "caseStatus",
        .closed_date = "closedDate",
        .created_date = "createdDate",
        .engagement_type = "engagementType",
        .last_updated_date = "lastUpdatedDate",
        .pending_action = "pendingAction",
        .resolver_type = "resolverType",
        .title = "title",
    };
};
