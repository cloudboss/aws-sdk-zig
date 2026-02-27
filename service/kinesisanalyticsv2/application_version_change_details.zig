/// Contains information about the version changes that the operation applied to
/// the application.
pub const ApplicationVersionChangeDetails = struct {
    /// The new version that the application was updated to.
    application_version_updated_from: i64,

    /// The version that the operation execution applied to the applicartion.
    application_version_updated_to: i64,

    pub const json_field_names = .{
        .application_version_updated_from = "ApplicationVersionUpdatedFrom",
        .application_version_updated_to = "ApplicationVersionUpdatedTo",
    };
};
