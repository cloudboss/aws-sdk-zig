const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Contains information about a workflow type.
pub const WorkflowTypeInfo = struct {
    /// The date when this type was registered.
    creation_date: i64,

    /// If the type is in deprecated state, then it is set to the date when the type
    /// was deprecated.
    deprecation_date: ?i64 = null,

    /// The description of the type registered through RegisterWorkflowType.
    description: ?[]const u8 = null,

    /// The current status of the workflow type.
    status: RegistrationStatus,

    /// The workflow type this information is about.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .deprecation_date = "deprecationDate",
        .description = "description",
        .status = "status",
        .workflow_type = "workflowType",
    };
};
