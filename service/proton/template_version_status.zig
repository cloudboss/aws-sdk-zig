pub const TemplateVersionStatus = enum {
    registration_in_progress,
    registration_failed,
    draft,
    published,

    pub const json_field_names = .{
        .registration_in_progress = "REGISTRATION_IN_PROGRESS",
        .registration_failed = "REGISTRATION_FAILED",
        .draft = "DRAFT",
        .published = "PUBLISHED",
    };
};
