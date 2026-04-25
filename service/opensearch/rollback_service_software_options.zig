/// Details about the rollback options for a service software update.
pub const RollbackServiceSoftwareOptions = struct {
    /// The current service software version on the domain.
    current_version: ?[]const u8 = null,

    /// A description of the rollback status.
    description: ?[]const u8 = null,

    /// The service software version that the domain will roll back to.
    new_version: ?[]const u8 = null,

    /// Whether a service software rollback is available for the domain.
    rollback_available: ?bool = null,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
        .description = "Description",
        .new_version = "NewVersion",
        .rollback_available = "RollbackAvailable",
    };
};
