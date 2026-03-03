const BodySectionDynamicCategoryDimensionConfiguration = @import("body_section_dynamic_category_dimension_configuration.zig").BodySectionDynamicCategoryDimensionConfiguration;
const BodySectionDynamicNumericDimensionConfiguration = @import("body_section_dynamic_numeric_dimension_configuration.zig").BodySectionDynamicNumericDimensionConfiguration;

/// Describes the dataset column and constraints for the dynamic values used to
/// repeat the contents of a section. The dataset column is either **Category**
/// or **Numeric** column configuration
pub const BodySectionRepeatDimensionConfiguration = struct {
    /// Describes the **Category** dataset column and constraints around the dynamic
    /// values that will be used in repeating the section contents.
    dynamic_category_dimension_configuration: ?BodySectionDynamicCategoryDimensionConfiguration = null,

    /// Describes the **Numeric** dataset column and constraints around the dynamic
    /// values used to repeat the contents of a section.
    dynamic_numeric_dimension_configuration: ?BodySectionDynamicNumericDimensionConfiguration = null,

    pub const json_field_names = .{
        .dynamic_category_dimension_configuration = "DynamicCategoryDimensionConfiguration",
        .dynamic_numeric_dimension_configuration = "DynamicNumericDimensionConfiguration",
    };
};
