const EntityType = @import("entity_type.zig").EntityType;
const Severity = @import("severity.zig").Severity;
const State = @import("state.zig").State;
const Status = @import("status.zig").Status;

/// Details about the investigation related to a potential security event
/// identified by Detective.
pub const InvestigationDetail = struct {
    /// The time stamp of the creation time of the investigation report. The value
    /// is an UTC ISO8601 formatted
    /// string. For example, `2021-08-18T16:35:56.284Z`.
    created_time: ?i64 = null,

    /// The unique Amazon Resource Name (ARN) of the IAM user and IAM role.
    entity_arn: ?[]const u8 = null,

    /// Type of entity. For example, Amazon Web Services accounts, such as IAM user
    /// and role.
    entity_type: ?EntityType = null,

    /// The investigation ID of the investigation report.
    investigation_id: ?[]const u8 = null,

    /// Severity based on the likelihood and impact of the indicators of compromise
    /// discovered in the investigation.
    severity: ?Severity = null,

    /// The current state of the investigation. An archived investigation indicates
    /// you have completed reviewing the investigation.
    state: ?State = null,

    /// Status based on the completion status of the investigation.
    status: ?Status = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .entity_arn = "EntityArn",
        .entity_type = "EntityType",
        .investigation_id = "InvestigationId",
        .severity = "Severity",
        .state = "State",
        .status = "Status",
    };
};
