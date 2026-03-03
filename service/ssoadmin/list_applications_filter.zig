/// A structure that describes a filter for applications.
pub const ListApplicationsFilter = struct {
    /// An Amazon Web Services account ID number that filters the results in the
    /// response.
    application_account: ?[]const u8 = null,

    /// The ARN of an application provider that can filter the results in the
    /// response.
    application_provider: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_account = "ApplicationAccount",
        .application_provider = "ApplicationProvider",
    };
};
