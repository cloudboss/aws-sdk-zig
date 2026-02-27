const ArchiveS3Settings = @import("archive_s3_settings.zig").ArchiveS3Settings;

/// Archive Cdn Settings
pub const ArchiveCdnSettings = struct {
    archive_s3_settings: ?ArchiveS3Settings,

    pub const json_field_names = .{
        .archive_s3_settings = "ArchiveS3Settings",
    };
};
