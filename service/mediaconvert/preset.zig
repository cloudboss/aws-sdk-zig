const PresetSettings = @import("preset_settings.zig").PresetSettings;
const Type = @import("type.zig").Type;

/// A preset is a collection of preconfigured media conversion settings that you
/// want MediaConvert to apply to the output during the conversion process.
pub const Preset = struct {
    /// An identifier for this resource that is unique within all of AWS.
    arn: ?[]const u8,

    /// An optional category you create to organize your presets.
    category: ?[]const u8,

    /// The timestamp in epoch seconds for preset creation.
    created_at: ?i64,

    /// An optional description you create for each preset.
    description: ?[]const u8,

    /// The timestamp in epoch seconds when the preset was last updated.
    last_updated: ?i64,

    /// A name you create for each preset. Each name must be unique within your
    /// account.
    name: []const u8,

    /// Settings for preset
    settings: PresetSettings,

    /// A preset can be of two types: system or custom. System or built-in preset
    /// can't be modified or deleted by the user.
    @"type": ?Type,

    pub const json_field_names = .{
        .arn = "Arn",
        .category = "Category",
        .created_at = "CreatedAt",
        .description = "Description",
        .last_updated = "LastUpdated",
        .name = "Name",
        .settings = "Settings",
        .@"type" = "Type",
    };
};
