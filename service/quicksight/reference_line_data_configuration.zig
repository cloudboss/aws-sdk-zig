const AxisBinding = @import("axis_binding.zig").AxisBinding;
const ReferenceLineDynamicDataConfiguration = @import("reference_line_dynamic_data_configuration.zig").ReferenceLineDynamicDataConfiguration;
const ReferenceLineSeriesType = @import("reference_line_series_type.zig").ReferenceLineSeriesType;
const ReferenceLineStaticDataConfiguration = @import("reference_line_static_data_configuration.zig").ReferenceLineStaticDataConfiguration;

/// The data configuration of the reference line.
pub const ReferenceLineDataConfiguration = struct {
    /// The axis binding type of the reference line. Choose one of the following
    /// options:
    ///
    /// * `PrimaryY`
    ///
    /// * `SecondaryY`
    axis_binding: ?AxisBinding = null,

    /// The dynamic configuration of the reference line data configuration.
    dynamic_configuration: ?ReferenceLineDynamicDataConfiguration = null,

    /// The series type of the reference line data configuration. Choose one of the
    /// following options:
    ///
    /// * `BAR`
    ///
    /// * `LINE`
    series_type: ?ReferenceLineSeriesType = null,

    /// The static data configuration of the reference line data configuration.
    static_configuration: ?ReferenceLineStaticDataConfiguration = null,

    pub const json_field_names = .{
        .axis_binding = "AxisBinding",
        .dynamic_configuration = "DynamicConfiguration",
        .series_type = "SeriesType",
        .static_configuration = "StaticConfiguration",
    };
};
