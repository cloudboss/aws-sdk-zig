const aws = @import("aws");

const ComplianceExecutionSummary = @import("compliance_execution_summary.zig").ComplianceExecutionSummary;
const ComplianceSeverity = @import("compliance_severity.zig").ComplianceSeverity;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Information about the compliance as defined by the resource type. For
/// example, for a patch
/// resource type, `Items` includes information about the PatchSeverity,
/// Classification,
/// and so on.
pub const ComplianceItem = struct {
    /// The compliance type. For example, Association (for a State Manager
    /// association), Patch, or
    /// Custom:`string` are all valid compliance types.
    compliance_type: ?[]const u8,

    /// A "Key": "Value" tag combination for the compliance item.
    details: ?[]const aws.map.StringMapEntry,

    /// A summary for the compliance item. The summary includes an execution ID, the
    /// execution type
    /// (for example, command), and the execution time.
    ///
    /// **Important:**
    ///
    /// For State Manager associations, the `ExecutionTime` value represents when
    /// the
    /// compliance status was captured and aggregated by the Systems Manager
    /// service, not necessarily when the
    /// underlying association was executed on the managed node. State Manager
    /// updates compliance status
    /// for all associations on an instance whenever any association executes, which
    /// means multiple
    /// associations may show the same execution time even if they were executed at
    /// different
    /// times.
    execution_summary: ?ComplianceExecutionSummary,

    /// An ID for the compliance item. For example, if the compliance item is a
    /// Windows patch, the
    /// ID could be the number of the KB article; for example: KB4010320.
    id: ?[]const u8,

    /// An ID for the resource. For a managed node, this is the node ID.
    resource_id: ?[]const u8,

    /// The type of resource. `ManagedInstance` is currently the only supported
    /// resource
    /// type.
    resource_type: ?[]const u8,

    /// The severity of the compliance status. Severity can be one of the following:
    /// Critical, High,
    /// Medium, Low, Informational, Unspecified.
    severity: ?ComplianceSeverity,

    /// The status of the compliance item. An item is either COMPLIANT,
    /// NON_COMPLIANT, or an empty
    /// string (for Windows patches that aren't applicable).
    status: ?ComplianceStatus,

    /// A title for the compliance item. For example, if the compliance item is a
    /// Windows patch, the
    /// title could be the title of the KB article for the patch; for example:
    /// Security Update for Active
    /// Directory Federation Services.
    title: ?[]const u8,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .details = "Details",
        .execution_summary = "ExecutionSummary",
        .id = "Id",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .severity = "Severity",
        .status = "Status",
        .title = "Title",
    };
};
