/// Configuration for the Wickr shredder feature, which writes random data over
/// free memory and disk space on client devices. You can configure your Wickr
/// shredder intensity using the parameters below.
///
/// Secure Shredder will not write over files that are permanently stored on the
/// device or saved outside of the Wickr client. Wickr Network Administrators
/// are able to disable file downloads within Security Group Settings.
pub const ShredderSettings = struct {
    /// Specifies whether users can manually trigger the shredder to delete content.
    can_process_manually: ?bool = null,

    /// Controls the rate (MB/minute) at which the shredder function runs on
    /// clients. Valid Values: Must be one of [0, 20, 60, 100].
    ///
    /// A higher intensity setting could lead to higher battery usage on mobile
    /// devices.
    intensity: ?i32 = null,

    pub const json_field_names = .{
        .can_process_manually = "canProcessManually",
        .intensity = "intensity",
    };
};
