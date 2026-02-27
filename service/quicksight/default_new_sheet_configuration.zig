const DefaultInteractiveLayoutConfiguration = @import("default_interactive_layout_configuration.zig").DefaultInteractiveLayoutConfiguration;
const DefaultPaginatedLayoutConfiguration = @import("default_paginated_layout_configuration.zig").DefaultPaginatedLayoutConfiguration;
const SheetContentType = @import("sheet_content_type.zig").SheetContentType;

/// The configuration for default new sheet settings.
pub const DefaultNewSheetConfiguration = struct {
    /// The options that determine the default settings for interactive layout
    /// configuration.
    interactive_layout_configuration: ?DefaultInteractiveLayoutConfiguration,

    /// The options that determine the default settings for a paginated layout
    /// configuration.
    paginated_layout_configuration: ?DefaultPaginatedLayoutConfiguration,

    /// The option that determines the sheet content type.
    sheet_content_type: ?SheetContentType,

    pub const json_field_names = .{
        .interactive_layout_configuration = "InteractiveLayoutConfiguration",
        .paginated_layout_configuration = "PaginatedLayoutConfiguration",
        .sheet_content_type = "SheetContentType",
    };
};
