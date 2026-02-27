const ColorsConfiguration = @import("colors_configuration.zig").ColorsConfiguration;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DecalSettingsConfiguration = @import("decal_settings_configuration.zig").DecalSettingsConfiguration;
const FormatConfiguration = @import("format_configuration.zig").FormatConfiguration;
const ColumnRole = @import("column_role.zig").ColumnRole;

/// The general configuration of a column.
pub const ColumnConfiguration = struct {
    /// The color configurations of the column.
    colors_configuration: ?ColorsConfiguration,

    /// The column.
    column: ColumnIdentifier,

    /// Decal configuration of the column.
    decal_settings_configuration: ?DecalSettingsConfiguration,

    /// The format configuration of a column.
    format_configuration: ?FormatConfiguration,

    /// The role of the column.
    role: ?ColumnRole,

    pub const json_field_names = .{
        .colors_configuration = "ColorsConfiguration",
        .column = "Column",
        .decal_settings_configuration = "DecalSettingsConfiguration",
        .format_configuration = "FormatConfiguration",
        .role = "Role",
    };
};
