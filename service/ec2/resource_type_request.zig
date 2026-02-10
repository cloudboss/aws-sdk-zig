const ImageReferenceResourceType = @import("image_reference_resource_type.zig").ImageReferenceResourceType;
const ResourceTypeOption = @import("resource_type_option.zig").ResourceTypeOption;

/// A resource type to check for image references. Associated options can also
/// be specified if the
/// resource type is an EC2 instance or launch template.
pub const ResourceTypeRequest = struct {
    /// The resource type.
    resource_type: ?ImageReferenceResourceType,

    /// The options that affect the scope of the response. Valid only when
    /// `ResourceType` is `ec2:Instance` or
    /// `ec2:LaunchTemplate`.
    resource_type_options: ?[]const ResourceTypeOption,
};
