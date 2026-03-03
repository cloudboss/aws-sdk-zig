const ArchiveCdnSettings = @import("archive_cdn_settings.zig").ArchiveCdnSettings;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;

/// Archive Group Settings
pub const ArchiveGroupSettings = struct {
    /// Parameters that control interactions with the CDN.
    archive_cdn_settings: ?ArchiveCdnSettings = null,

    /// A directory and base filename where archive files should be written.
    destination: OutputLocationRef,

    /// Number of seconds to write to archive file before closing and starting a new
    /// one.
    rollover_interval: ?i32 = null,

    pub const json_field_names = .{
        .archive_cdn_settings = "ArchiveCdnSettings",
        .destination = "Destination",
        .rollover_interval = "RolloverInterval",
    };
};
