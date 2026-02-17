const aws = @import("aws");

const AssociationOverview = @import("association_overview.zig").AssociationOverview;
const Target = @import("target.zig").Target;

/// Describes an association of a Amazon Web Services Systems Manager document
/// (SSM document) and a managed node.
pub const Association = struct {
    /// The ID created by the system when you create an association. An association
    /// is a binding
    /// between a document and a set of targets with a schedule.
    association_id: ?[]const u8,

    /// The association name.
    association_name: ?[]const u8,

    /// The association version.
    association_version: ?[]const u8,

    /// The version of the document used in the association. If you change a
    /// document version for a
    /// State Manager association, Systems Manager immediately runs the association
    /// unless you previously specifed
    /// the `apply-only-at-cron-interval` parameter.
    ///
    /// State Manager doesn't support running associations that use a new version of
    /// a document if
    /// that document is shared from another account. State Manager always runs the
    /// `default`
    /// version of a document if shared from another account, even though the
    /// Systems Manager console shows that a
    /// new version was processed. If you want to run an association using a new
    /// version of a document
    /// shared form another account, you must set the document version to `default`.
    document_version: ?[]const u8,

    /// The number of hours that an association can run on specified targets. After
    /// the resulting
    /// cutoff time passes, associations that are currently running are cancelled,
    /// and no pending
    /// executions are started on remaining targets.
    duration: ?i32,

    /// The managed node ID.
    instance_id: ?[]const u8,

    /// The date on which the association was last run.
    last_execution_date: ?i64,

    /// The name of the SSM document.
    name: ?[]const u8,

    /// Information about the association.
    overview: ?AssociationOverview,

    /// A cron expression that specifies a schedule when the association runs. The
    /// schedule runs in
    /// Coordinated Universal Time (UTC).
    schedule_expression: ?[]const u8,

    /// Number of days to wait after the scheduled day to run an association.
    schedule_offset: ?i32,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The managed nodes targeted by the request to create an association. You can
    /// target all
    /// managed nodes in an Amazon Web Services account by specifying the
    /// `InstanceIds` key with a value of
    /// `*`.
    targets: ?[]const Target,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .association_name = "AssociationName",
        .association_version = "AssociationVersion",
        .document_version = "DocumentVersion",
        .duration = "Duration",
        .instance_id = "InstanceId",
        .last_execution_date = "LastExecutionDate",
        .name = "Name",
        .overview = "Overview",
        .schedule_expression = "ScheduleExpression",
        .schedule_offset = "ScheduleOffset",
        .target_maps = "TargetMaps",
        .targets = "Targets",
    };
};
