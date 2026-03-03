/// A code and name pair that represents the severity level of a support case.
/// The
/// available values depend on the support plan for the account. For more
/// information, see
/// [Choosing a
/// severity](https://docs.aws.amazon.com/awssupport/latest/user/case-management.html#choosing-severity) in the *Amazon Web Services Support User Guide*.
pub const SeverityLevel = struct {
    /// The code for case severity level.
    ///
    /// Valid values: `low` | `normal` | `high` |
    /// `urgent` | `critical`
    code: ?[]const u8 = null,

    /// The name of the severity level that corresponds to the severity level code.
    ///
    /// The values returned by the API are different from the values that appear in
    /// the
    /// Amazon Web Services Support Center. For example, the API uses the code
    /// `low`, but the name
    /// appears as General guidance in Support Center.
    ///
    /// The following are the API code names and how they appear in the console:
    ///
    /// * `low` - General guidance
    ///
    /// * `normal` - System impaired
    ///
    /// * `high` - Production system impaired
    ///
    /// * `urgent` - Production system down
    ///
    /// * `critical` - Business-critical system down
    ///
    /// For more information, see [Choosing a
    /// severity](https://docs.aws.amazon.com/awssupport/latest/user/case-management.html#choosing-severity) in the *Amazon Web Services Support User Guide*.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .name = "name",
    };
};
