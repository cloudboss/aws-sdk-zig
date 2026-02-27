/// State of an `AlertManagerDefinition`.
pub const AlertManagerDefinitionStatusCode = enum {
    /// Definition is being created. Update/Deletion is disallowed until definition
    /// is ACTIVE and workspace status is ACTIVE.
    creating,
    /// Definition has been created/updated. Update/Deletion is disallowed until
    /// definition is ACTIVE and workspace status is ACTIVE.
    active,
    /// Definition is being updated. Update/Deletion is disallowed until definition
    /// is ACTIVE and workspace status is ACTIVE.
    updating,
    /// Definition is being deleting. Update/Deletion is disallowed until definition
    /// is ACTIVE and workspace status is ACTIVE.
    deleting,
    /// Definition creation failed.
    creation_failed,
    /// Definition update failed.
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
    };
};
