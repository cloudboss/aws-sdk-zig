const ArchiveContainerSettings = @import("archive_container_settings.zig").ArchiveContainerSettings;

/// Archive Output Settings
pub const ArchiveOutputSettings = struct {
    /// Container for this output. Can be auto-detected from extension field.
    container_settings: ArchiveContainerSettings,

    /// Output file extension. If excluded, this will be auto-selected from the
    /// container type.
    extension: ?[]const u8,

    /// String concatenated to the end of the destination filename. Required for
    /// multiple outputs of the same type.
    name_modifier: ?[]const u8,

    pub const json_field_names = .{
        .container_settings = "ContainerSettings",
        .extension = "Extension",
        .name_modifier = "NameModifier",
    };
};
