/// Describes the permissions for an image.
pub const ImagePermissions = struct {
    /// Indicates whether the image can be used for a fleet.
    allow_fleet: ?bool = null,

    /// Indicates whether the image can be used for an image builder.
    allow_image_builder: ?bool = null,

    pub const json_field_names = .{
        .allow_fleet = "allowFleet",
        .allow_image_builder = "allowImageBuilder",
    };
};
