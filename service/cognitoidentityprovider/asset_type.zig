const AssetCategoryType = @import("asset_category_type.zig").AssetCategoryType;
const ColorSchemeModeType = @import("color_scheme_mode_type.zig").ColorSchemeModeType;
const AssetExtensionType = @import("asset_extension_type.zig").AssetExtensionType;

/// An image file from a managed login branding style in a user pool.
pub const AssetType = struct {
    /// The image file, in Base64-encoded binary.
    bytes: ?[]const u8 = null,

    /// The category that the image corresponds to in your managed login
    /// configuration.
    /// Managed login has asset categories for different types of logos,
    /// backgrounds, and
    /// icons.
    category: AssetCategoryType,

    /// The display-mode target of the asset: light, dark, or browser-adaptive. For
    /// example,
    /// Amazon Cognito displays a dark-mode image only when the browser or
    /// application is in dark mode,
    /// but displays a browser-adaptive file in all contexts.
    color_mode: ColorSchemeModeType,

    /// The file type of the image file.
    extension: AssetExtensionType,

    /// The ID of the asset.
    resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "Bytes",
        .category = "Category",
        .color_mode = "ColorMode",
        .extension = "Extension",
        .resource_id = "ResourceId",
    };
};
