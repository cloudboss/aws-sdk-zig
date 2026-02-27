const TableFieldURLConfiguration = @import("table_field_url_configuration.zig").TableFieldURLConfiguration;
const Visibility = @import("visibility.zig").Visibility;

/// The options for a table field.
pub const TableFieldOption = struct {
    /// The custom label for a table field.
    custom_label: ?[]const u8,

    /// The field ID for a table field.
    field_id: []const u8,

    /// The URL configuration for a table field.
    url_styling: ?TableFieldURLConfiguration,

    /// The visibility of a table field.
    visibility: ?Visibility,

    /// The width for a table field.
    width: ?[]const u8,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .field_id = "FieldId",
        .url_styling = "URLStyling",
        .visibility = "Visibility",
        .width = "Width",
    };
};
