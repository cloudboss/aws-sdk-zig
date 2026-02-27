/// The theme colors that apply to UI and to charts, excluding data colors. The
/// colors
/// description is a hexadecimal color code that consists of six alphanumerical
/// characters,
/// prefixed with `#`, for example #37BFF5. For more information, see [Using
/// Themes in Quick
/// Sight](https://docs.aws.amazon.com/quicksight/latest/user/themes-in-quicksight.html) in the *Quick Sight User
/// Guide.*
pub const UIColorPalette = struct {
    /// This color is that applies to selected states and buttons.
    accent: ?[]const u8,

    /// The foreground color that applies to any text or other elements that appear
    /// over the
    /// accent color.
    accent_foreground: ?[]const u8,

    /// The color that applies to error messages.
    danger: ?[]const u8,

    /// The foreground color that applies to any text or other elements that appear
    /// over the
    /// error color.
    danger_foreground: ?[]const u8,

    /// The color that applies to the names of fields that are identified as
    /// dimensions.
    dimension: ?[]const u8,

    /// The foreground color that applies to any text or other elements that appear
    /// over the
    /// dimension color.
    dimension_foreground: ?[]const u8,

    /// The color that applies to the names of fields that are identified as
    /// measures.
    measure: ?[]const u8,

    /// The foreground color that applies to any text or other elements that appear
    /// over the
    /// measure color.
    measure_foreground: ?[]const u8,

    /// The background color that applies to visuals and other high emphasis UI.
    primary_background: ?[]const u8,

    /// The color of text and other foreground elements that appear over the primary
    /// background regions, such as grid lines, borders, table banding, icons, and
    /// so on.
    primary_foreground: ?[]const u8,

    /// The background color that applies to the sheet background and sheet
    /// controls.
    secondary_background: ?[]const u8,

    /// The foreground color that applies to any sheet title, sheet control text, or
    /// UI that
    /// appears over the secondary background.
    secondary_foreground: ?[]const u8,

    /// The color that applies to success messages, for example the check mark for a
    /// successful download.
    success: ?[]const u8,

    /// The foreground color that applies to any text or other elements that appear
    /// over the
    /// success color.
    success_foreground: ?[]const u8,

    /// This color that applies to warning and informational messages.
    warning: ?[]const u8,

    /// The foreground color that applies to any text or other elements that appear
    /// over the
    /// warning color.
    warning_foreground: ?[]const u8,

    pub const json_field_names = .{
        .accent = "Accent",
        .accent_foreground = "AccentForeground",
        .danger = "Danger",
        .danger_foreground = "DangerForeground",
        .dimension = "Dimension",
        .dimension_foreground = "DimensionForeground",
        .measure = "Measure",
        .measure_foreground = "MeasureForeground",
        .primary_background = "PrimaryBackground",
        .primary_foreground = "PrimaryForeground",
        .secondary_background = "SecondaryBackground",
        .secondary_foreground = "SecondaryForeground",
        .success = "Success",
        .success_foreground = "SuccessForeground",
        .warning = "Warning",
        .warning_foreground = "WarningForeground",
    };
};
