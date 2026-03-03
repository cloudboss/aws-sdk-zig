const CustomImage = @import("custom_image.zig").CustomImage;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// A collection of settings that apply to an `RSessionGateway` app.
pub const RSessionAppSettings = struct {
    /// A list of custom SageMaker AI images that are configured to run as a
    /// RSession app.
    custom_images: ?[]const CustomImage = null,

    default_resource_spec: ?ResourceSpec = null,

    pub const json_field_names = .{
        .custom_images = "CustomImages",
        .default_resource_spec = "DefaultResourceSpec",
    };
};
