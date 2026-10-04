/// The progress of a domain deletion, including the number of projects that
/// Amazon DataZone successfully deleted. Amazon DataZone returns this structure
/// in the response to a `GetDomain` request while a cascade deletion is in
/// progress.
pub const DeleteProgress = struct {
    /// The number of projects that Amazon DataZone successfully deleted during the
    /// domain deletion.
    successfully_deleted_project_count: ?i32 = null,

    pub const json_field_names = .{
        .successfully_deleted_project_count = "successfullyDeletedProjectCount",
    };
};
