const GlobalTableBorderOptions = @import("global_table_border_options.zig").GlobalTableBorderOptions;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const HorizontalTextAlignment = @import("horizontal_text_alignment.zig").HorizontalTextAlignment;
const TextWrap = @import("text_wrap.zig").TextWrap;
const VerticalTextAlignment = @import("vertical_text_alignment.zig").VerticalTextAlignment;
const Visibility = @import("visibility.zig").Visibility;

/// The table cell style for a cell in pivot table or table visual.
pub const TableCellStyle = struct {
    /// The background color for the table cells.
    background_color: ?[]const u8,

    /// The borders for the table cells.
    border: ?GlobalTableBorderOptions,

    /// The font configuration of the table cells.
    font_configuration: ?FontConfiguration,

    /// The height color for the table cells.
    height: ?i32,

    /// The horizontal text alignment (left, center, right, auto) for the table
    /// cells.
    horizontal_text_alignment: ?HorizontalTextAlignment,

    /// The text wrap (none, wrap) for the table cells.
    text_wrap: ?TextWrap,

    /// The vertical text alignment (top, middle, bottom) for the table cells.
    vertical_text_alignment: ?VerticalTextAlignment,

    /// The visibility of the table cells.
    visibility: ?Visibility,

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
