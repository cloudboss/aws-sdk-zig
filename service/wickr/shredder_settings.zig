/// Configuration for the message shredder feature, which securely deletes
/// messages and files from devices to prevent data recovery.
pub const ShredderSettings = struct {
    /// Specifies whether users can manually trigger the shredder to delete content.
    can_process_manually: ?bool = null,

    /// Prevents Wickr data from being recovered by overwriting deleted Wickr data.
    /// Valid Values: Must be one of [0, 20, 60, 100]
    intensity: ?i32 = null,

    pub const json_field_names = .{
        .can_process_manually = "canProcessManually",
        .intensity = "intensity",
    };
};
