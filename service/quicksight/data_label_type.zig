const DataPathLabelType = @import("data_path_label_type.zig").DataPathLabelType;
const FieldLabelType = @import("field_label_type.zig").FieldLabelType;
const MaximumLabelType = @import("maximum_label_type.zig").MaximumLabelType;
const MinimumLabelType = @import("minimum_label_type.zig").MinimumLabelType;
const RangeEndsLabelType = @import("range_ends_label_type.zig").RangeEndsLabelType;

/// The option that determines the data label type.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const DataLabelType = struct {
    /// The option that specifies individual data values for labels.
    data_path_label_type: ?DataPathLabelType = null,

    /// Determines the label configuration for the entire field.
    field_label_type: ?FieldLabelType = null,

    /// Determines the label configuration for the maximum value in a visual.
    maximum_label_type: ?MaximumLabelType = null,

    /// Determines the label configuration for the minimum value in a visual.
    minimum_label_type: ?MinimumLabelType = null,

    /// Determines the label configuration for range end value in a visual.
    range_ends_label_type: ?RangeEndsLabelType = null,

    pub const json_field_names = .{
        .data_path_label_type = "DataPathLabelType",
        .field_label_type = "FieldLabelType",
        .maximum_label_type = "MaximumLabelType",
        .minimum_label_type = "MinimumLabelType",
        .range_ends_label_type = "RangeEndsLabelType",
    };
};
