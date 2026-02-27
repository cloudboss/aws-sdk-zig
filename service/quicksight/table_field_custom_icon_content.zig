const TableFieldIconSetType = @import("table_field_icon_set_type.zig").TableFieldIconSetType;

/// The custom icon content for the table link content configuration.
pub const TableFieldCustomIconContent = struct {
    /// The icon set type (link) of the custom icon content for table URL link
    /// content.
    icon: ?TableFieldIconSetType,

    pub const json_field_names = .{
        .icon = "Icon",
    };
};
