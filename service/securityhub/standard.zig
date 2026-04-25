const StandardsManagedBy = @import("standards_managed_by.zig").StandardsManagedBy;

/// Provides information about a specific security standard.
pub const Standard = struct {
    /// A description of the standard.
    description: ?[]const u8 = null,

    /// Whether the standard is enabled by default. When Security Hub CSPM is
    /// enabled from the console, if a
    /// standard is enabled by default, the check box for that standard is selected
    /// by
    /// default.
    ///
    /// When Security Hub CSPM is enabled using the `EnableSecurityHub` API
    /// operation, the
    /// standard is enabled by default unless `EnableDefaultStandards` is set to
    /// `false`.
    enabled_by_default: ?bool = null,

    /// The name of the standard.
    name: ?[]const u8 = null,

    /// The ARN of the standard.
    standards_arn: ?[]const u8 = null,

    /// Provides details about the management of a standard.
    standards_managed_by: ?StandardsManagedBy = null,

    pub const json_field_names = .{
        .description = "Description",
        .enabled_by_default = "EnabledByDefault",
        .name = "Name",
        .standards_arn = "StandardsArn",
        .standards_managed_by = "StandardsManagedBy",
    };
};
