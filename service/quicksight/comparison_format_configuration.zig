const NumberDisplayFormatConfiguration = @import("number_display_format_configuration.zig").NumberDisplayFormatConfiguration;
const PercentageDisplayFormatConfiguration = @import("percentage_display_format_configuration.zig").PercentageDisplayFormatConfiguration;

/// The format of the comparison.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const ComparisonFormatConfiguration = struct {
    /// The number display format.
    number_display_format_configuration: ?NumberDisplayFormatConfiguration,

    /// The percentage display format.
    percentage_display_format_configuration: ?PercentageDisplayFormatConfiguration,

    pub const json_field_names = .{
        .number_display_format_configuration = "NumberDisplayFormatConfiguration",
        .percentage_display_format_configuration = "PercentageDisplayFormatConfiguration",
    };
};
