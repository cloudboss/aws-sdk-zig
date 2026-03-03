const AppCategory = @import("app_category.zig").AppCategory;
const InstancePlatform = @import("instance_platform.zig").InstancePlatform;
const BlueprintType = @import("blueprint_type.zig").BlueprintType;

/// Describes a blueprint (a virtual private server image).
pub const Blueprint = struct {
    /// Virtual computer blueprints that are supported by Lightsail for Research.
    ///
    /// This parameter only applies to Lightsail for Research resources.
    app_category: ?AppCategory = null,

    /// The ID for the virtual private server image (`app_wordpress_x_x` or
    /// `app_lamp_x_x`).
    blueprint_id: ?[]const u8 = null,

    /// The description of the blueprint.
    description: ?[]const u8 = null,

    /// The group name of the blueprint (`amazon-linux`).
    group: ?[]const u8 = null,

    /// A Boolean value indicating whether the blueprint is active. Inactive
    /// blueprints are listed
    /// to support customers with existing instances but are not necessarily
    /// available for launch of
    /// new instances. Blueprints are marked inactive when they become outdated due
    /// to operating
    /// system updates or new application releases.
    is_active: ?bool = null,

    /// The end-user license agreement URL for the image or blueprint.
    license_url: ?[]const u8 = null,

    /// The minimum bundle power required to run this blueprint. For example, you
    /// need a bundle
    /// with a power value of 500 or more to create an instance that uses a
    /// blueprint with a minimum
    /// power value of 500. `0` indicates that the blueprint runs on all instance
    /// sizes.
    min_power: ?i32 = null,

    /// The friendly name of the blueprint (`Amazon Linux`).
    name: ?[]const u8 = null,

    /// The operating system platform (either Linux/Unix-based or Windows
    /// Server-based) of the
    /// blueprint.
    platform: ?InstancePlatform = null,

    /// The product URL to learn more about the image or blueprint.
    product_url: ?[]const u8 = null,

    /// The type of the blueprint (`os` or `app`).
    @"type": ?BlueprintType = null,

    /// The version number of the operating system, application, or stack (
    /// `2016.03.0`).
    version: ?[]const u8 = null,

    /// The version code.
    version_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_category = "appCategory",
        .blueprint_id = "blueprintId",
        .description = "description",
        .group = "group",
        .is_active = "isActive",
        .license_url = "licenseUrl",
        .min_power = "minPower",
        .name = "name",
        .platform = "platform",
        .product_url = "productUrl",
        .@"type" = "type",
        .version = "version",
        .version_code = "versionCode",
    };
};
