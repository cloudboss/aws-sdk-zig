const ImageUsageResourceTypeOption = @import("image_usage_resource_type_option.zig").ImageUsageResourceTypeOption;

/// A resource type to include in the report. Associated options can also be
/// specified if the
/// resource type is a launch template.
pub const ImageUsageResourceType = struct {
    /// The resource type.
    ///
    /// Valid values: `ec2:Instance` | `ec2:LaunchTemplate`
    resource_type: ?[]const u8 = null,

    /// The options that affect the scope of the report. Valid only when
    /// `ResourceType`
    /// is `ec2:LaunchTemplate`.
    resource_type_options: ?[]const ImageUsageResourceTypeOption = null,
};
