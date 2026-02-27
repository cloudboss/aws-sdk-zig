const DefaultNewSheetConfiguration = @import("default_new_sheet_configuration.zig").DefaultNewSheetConfiguration;

/// The configuration for default analysis settings.
pub const AnalysisDefaults = struct {
    /// The configuration for default new sheet settings.
    default_new_sheet_configuration: DefaultNewSheetConfiguration,

    pub const json_field_names = .{
        .default_new_sheet_configuration = "DefaultNewSheetConfiguration",
    };
};
