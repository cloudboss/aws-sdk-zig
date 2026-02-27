/// Specifies the name of the column that contains the unique identifier of your
/// users, whose privacy you want to protect.
pub const DifferentialPrivacyColumn = struct {
    /// The name of the column, such as user_id, that contains the unique identifier
    /// of your users, whose privacy you want to protect. If you want to turn on
    /// differential privacy for two or more tables in a collaboration, you must
    /// configure the same column as the user identifier column in both analysis
    /// rules.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
