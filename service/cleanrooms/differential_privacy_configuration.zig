const DifferentialPrivacyColumn = @import("differential_privacy_column.zig").DifferentialPrivacyColumn;

/// Specifies the unique identifier for your users.
pub const DifferentialPrivacyConfiguration = struct {
    /// The name of the column (such as user_id) that contains the unique identifier
    /// of your users whose privacy you want to protect. If you want to turn on
    /// diﬀerential privacy for two or more tables in a collaboration, you must
    /// conﬁgure the same column as the user identiﬁer column in both analysis
    /// rules.
    columns: []const DifferentialPrivacyColumn,

    pub const json_field_names = .{
        .columns = "columns",
    };
};
