const Visibility = @import("visibility.zig").Visibility;
const DataLabelType = @import("data_label_type.zig").DataLabelType;
const DataLabelContent = @import("data_label_content.zig").DataLabelContent;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const DataLabelOverlap = @import("data_label_overlap.zig").DataLabelOverlap;
const DataLabelPosition = @import("data_label_position.zig").DataLabelPosition;

/// The options that determine the presentation of the data labels.
pub const DataLabelOptions = struct {
    /// Determines the visibility of the category field labels.
    category_label_visibility: ?Visibility = null,

    /// The option that determines the data label type.
    data_label_types: ?[]const DataLabelType = null,

    /// Determines the color of the data labels.
    label_color: ?[]const u8 = null,

    /// Determines the content of the data labels.
    label_content: ?DataLabelContent = null,

    /// Determines the font configuration of the data labels.
    label_font_configuration: ?FontConfiguration = null,

    /// Determines the visibility of the measure field labels.
    measure_label_visibility: ?Visibility = null,

    /// Determines whether overlap is enabled or disabled for the data labels.
    overlap: ?DataLabelOverlap = null,

    /// Determines the position of the data labels.
    position: ?DataLabelPosition = null,

    /// Determines the visibility of the total.
    totals_visibility: ?Visibility = null,

    /// Determines the visibility of the data labels.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .category_label_visibility = "CategoryLabelVisibility",
        .data_label_types = "DataLabelTypes",
        .label_color = "LabelColor",
        .label_content = "LabelContent",
        .label_font_configuration = "LabelFontConfiguration",
        .measure_label_visibility = "MeasureLabelVisibility",
        .overlap = "Overlap",
        .position = "Position",
        .totals_visibility = "TotalsVisibility",
        .visibility = "Visibility",
    };
};
