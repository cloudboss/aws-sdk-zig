/// The description and metadata for a Trusted Advisor check.
pub const TrustedAdvisorCheckDescription = struct {
    /// The category of the Trusted Advisor check.
    category: []const u8,

    /// The description of the Trusted Advisor check, which includes the alert
    /// criteria and
    /// recommended operations (contains HTML markup).
    description: []const u8,

    /// The unique identifier for the Trusted Advisor check.
    id: []const u8,

    /// The column headings for the data returned by the Trusted Advisor check. The
    /// order of the
    /// headings corresponds to the order of the data in the **Metadata** element of
    /// the TrustedAdvisorResourceDetail
    /// for the check. **Metadata** contains all the data that is
    /// shown in the Excel download, even in those cases where the UI shows just
    /// summary data.
    metadata: []const []const u8,

    /// The display name for the Trusted Advisor check.
    name: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .description = "description",
        .id = "id",
        .metadata = "metadata",
        .name = "name",
    };
};
