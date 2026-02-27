const PredefinedAttributeConfiguration = @import("predefined_attribute_configuration.zig").PredefinedAttributeConfiguration;
const PredefinedAttributeValues = @import("predefined_attribute_values.zig").PredefinedAttributeValues;

/// Information about a predefined attribute.
pub const PredefinedAttribute = struct {
    /// Custom metadata that is associated to predefined attributes to control
    /// behavior
    /// in upstream services, such as controlling
    /// how a predefined attribute should be displayed in the Amazon Connect admin
    /// website.
    attribute_configuration: ?PredefinedAttributeConfiguration,

    /// Last modified region.
    last_modified_region: ?[]const u8,

    /// Last modified time.
    last_modified_time: ?i64,

    /// The name of the predefined attribute.
    name: ?[]const u8,

    /// Values that enable you to categorize your predefined attributes. You can use
    /// them in custom UI elements across the Amazon Connect admin website.
    purposes: ?[]const []const u8,

    /// The values of the predefined attribute.
    values: ?PredefinedAttributeValues,

    pub const json_field_names = .{
        .attribute_configuration = "AttributeConfiguration",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .purposes = "Purposes",
        .values = "Values",
    };
};
