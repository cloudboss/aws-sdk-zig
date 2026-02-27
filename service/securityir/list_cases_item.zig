const CaseStatus = @import("case_status.zig").CaseStatus;
const EngagementType = @import("engagement_type.zig").EngagementType;
const PendingAction = @import("pending_action.zig").PendingAction;
const ResolverType = @import("resolver_type.zig").ResolverType;

pub const ListCasesItem = struct {
    case_arn: ?[]const u8,

    case_id: []const u8,

    case_status: ?CaseStatus,

    closed_date: ?i64,

    created_date: ?i64,

    engagement_type: ?EngagementType,

    last_updated_date: ?i64,

    pending_action: ?PendingAction,

    resolver_type: ?ResolverType,

    title: ?[]const u8,

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
