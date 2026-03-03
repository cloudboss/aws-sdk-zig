const GlobalTableBorderOptions = @import("global_table_border_options.zig").GlobalTableBorderOptions;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const HorizontalTextAlignment = @import("horizontal_text_alignment.zig").HorizontalTextAlignment;
const TextWrap = @import("text_wrap.zig").TextWrap;
const VerticalTextAlignment = @import("vertical_text_alignment.zig").VerticalTextAlignment;
const Visibility = @import("visibility.zig").Visibility;

/// The table cell style for a cell in pivot table or table visual.
pub const TableCellStyle = struct {
    /// The background color for the table cells.
    background_color: ?[]const u8 = null,

    /// The borders for the table cells.
    border: ?GlobalTableBorderOptions = null,

    /// The font configuration of the table cells.
    font_configuration: ?FontConfiguration = null,

    /// The height color for the table cells.
    height: ?i32 = null,

    /// The horizontal text alignment (left, center, right, auto) for the table
    /// cells.
    horizontal_text_alignment: ?HorizontalTextAlignment = null,

    /// The text wrap (none, wrap) for the table cells.
    text_wrap: ?TextWrap = null,

    /// The vertical text alignment (top, middle, bottom) for the table cells.
    vertical_text_alignment: ?VerticalTextAlignment = null,

    /// The visibility of the table cells.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .border = "Border",
        .font_configuration = "FontConfiguration",
        .height = "Height",
        .horizontal_text_alignment = "HorizontalTextAlignment",
        .text_wrap = "TextWrap",
        .vertical_text_alignment = "VerticalTextAlignment",
        .visibility = "Visibility",
    };
};
