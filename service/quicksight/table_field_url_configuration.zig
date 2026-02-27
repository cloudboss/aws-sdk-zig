const TableFieldImageConfiguration = @import("table_field_image_configuration.zig").TableFieldImageConfiguration;
const TableFieldLinkConfiguration = @import("table_field_link_configuration.zig").TableFieldLinkConfiguration;

/// The URL configuration for a table field.
pub const TableFieldURLConfiguration = struct {
    /// The image configuration of a table field URL.
    image_configuration: ?TableFieldImageConfiguration,

    /// The link configuration of a table field URL.
    link_configuration: ?TableFieldLinkConfiguration,

    pub const json_field_names = .{
        .image_configuration = "ImageConfiguration",
        .link_configuration = "LinkConfiguration",
    };
};
