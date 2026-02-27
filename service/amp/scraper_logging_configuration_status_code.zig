pub const ScraperLoggingConfigurationStatusCode = enum {
    /// Scraper logging configuration is being created.
    creating,
    /// Scraper logging configuration is active.
    active,
    /// Scraper logging configuration is being updated.
    updating,
    /// Scraper logging configuration is being deleted.
    deleting,
    /// Scraper logging configuration creation failed.
    creation_failed,
    /// Scraper logging configuration update failed.
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
