const TableFieldLinkContentConfiguration = @import("table_field_link_content_configuration.zig").TableFieldLinkContentConfiguration;
const URLTargetConfiguration = @import("url_target_configuration.zig").URLTargetConfiguration;

/// The link configuration of a table field URL.
pub const TableFieldLinkConfiguration = struct {
    /// The URL content (text, icon) for the table link configuration.
    content: TableFieldLinkContentConfiguration,

    /// The URL target (new tab, new window, same tab) for the table link
    /// configuration.
    target: URLTargetConfiguration,

    pub const json_field_names = .{
        .content = "Content",
        .target = "Target",
    };
};
