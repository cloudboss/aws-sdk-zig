/// Contains information about a resource identified by a Trusted Advisor check.
pub const TrustedAdvisorResourceDetail = struct {
    /// Specifies whether the Amazon Web Services resource was ignored by Trusted
    /// Advisor because it was marked as
    /// suppressed by the user.
    is_suppressed: bool = false,

    /// Additional information about the identified resource. The exact metadata and
    /// its order
    /// can be obtained by inspecting the TrustedAdvisorCheckDescription
    /// object returned by the call to DescribeTrustedAdvisorChecks. **Metadata**
    /// contains all the data that is shown in the Excel
    /// download, even in those cases where the UI shows just summary data.
    metadata: []const []const u8,

    /// The Amazon Web Services Region in which the identified resource is located.
    region: ?[]const u8 = null,

    /// The unique identifier for the identified resource.
    resource_id: []const u8,

    /// The status code for the resource identified in the Trusted Advisor check.
    status: []const u8,

    pub const json_field_names = .{
        .is_suppressed = "isSuppressed",
        .metadata = "metadata",
        .region = "region",
        .resource_id = "resourceId",
        .status = "status",
    };
};
