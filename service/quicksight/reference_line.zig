const ReferenceLineDataConfiguration = @import("reference_line_data_configuration.zig").ReferenceLineDataConfiguration;
const ReferenceLineLabelConfiguration = @import("reference_line_label_configuration.zig").ReferenceLineLabelConfiguration;
const WidgetStatus = @import("widget_status.zig").WidgetStatus;
const ReferenceLineStyleConfiguration = @import("reference_line_style_configuration.zig").ReferenceLineStyleConfiguration;

/// The reference line visual display options.
pub const ReferenceLine = struct {
    /// The data configuration of the reference line.
    data_configuration: ReferenceLineDataConfiguration,

    /// The label configuration of the reference line.
    label_configuration: ?ReferenceLineLabelConfiguration,

    /// The status of the reference line. Choose one of the following options:
    ///
    /// * `ENABLE`
    ///
    /// * `DISABLE`
    status: ?WidgetStatus,

    /// The style configuration of the reference line.
    style_configuration: ?ReferenceLineStyleConfiguration,

    pub const json_field_names = .{
        .data_configuration = "DataConfiguration",
        .label_configuration = "LabelConfiguration",
        .status = "Status",
        .style_configuration = "StyleConfiguration",
    };
};
