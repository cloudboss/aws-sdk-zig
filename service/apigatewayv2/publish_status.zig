/// Represents a publish status.
pub const PublishStatus = enum {
    published,
    publish_in_progress,
    publish_failed,
    disabled,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .publish_in_progress = "PUBLISH_IN_PROGRESS",
        .publish_failed = "PUBLISH_FAILED",
        .disabled = "DISABLED",
    };
};
