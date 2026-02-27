/// State of a scraper.
pub const ScraperStatusCode = enum {
    /// Scraper is being created. Deletion is disallowed until status is ACTIVE.
    creating,
    /// Scraper is being updated. Deletion is disallowed until status is ACTIVE.
    updating,
    /// Scraper has been created and is usable.
    active,
    /// Scraper is being deleted. Deletions are allowed only when status is ACTIVE.
    deleting,
    /// Scraper creation failed.
    creation_failed,
    /// Scraper update failed.
    update_failed,
    /// Scraper deletion failed.
    deletion_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
        .deletion_failed = "DELETION_FAILED",
    };
};
