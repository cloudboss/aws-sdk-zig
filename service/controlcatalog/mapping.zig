const CommonControlMappingDetails = @import("common_control_mapping_details.zig").CommonControlMappingDetails;
const FrameworkMappingDetails = @import("framework_mapping_details.zig").FrameworkMappingDetails;
const RelatedControlMappingDetails = @import("related_control_mapping_details.zig").RelatedControlMappingDetails;

/// A structure that contains the details of a mapping relationship, which can
/// be either to a framework or to a common control.
pub const Mapping = union(enum) {
    /// The common control mapping details when the mapping type relates to a common
    /// control.
    common_control: ?CommonControlMappingDetails,
    /// The framework mapping details when the mapping type relates to a compliance
    /// framework.
    framework: ?FrameworkMappingDetails,
    /// Returns information about controls that are related to the specified
    /// control.
    related_control: ?RelatedControlMappingDetails,

    pub const json_field_names = .{
        .common_control = "CommonControl",
        .framework = "Framework",
        .related_control = "RelatedControl",
    };
};
