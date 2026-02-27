/// Part of `ListStorageLensConfigurationResult`. Each entry includes the
/// description of the S3 Storage Lens configuration, its home Region, whether
/// it is enabled, its
/// Amazon Resource Name (ARN), and config ID.
pub const ListStorageLensConfigurationEntry = struct {
    /// A container for the S3 Storage Lens home Region. Your metrics data is stored
    /// and retained in
    /// your designated S3 Storage Lens home Region.
    home_region: []const u8,

    /// A container for the S3 Storage Lens configuration ID.
    id: []const u8,

    /// A container for whether the S3 Storage Lens configuration is enabled. This
    /// property is
    /// required.
    is_enabled: bool = false,

    /// The ARN of the S3 Storage Lens configuration. This property is read-only.
    storage_lens_arn: []const u8,
};
