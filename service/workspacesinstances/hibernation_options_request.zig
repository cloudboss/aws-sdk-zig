/// Defines hibernation configuration for the WorkSpace Instance.
pub const HibernationOptionsRequest = struct {
    /// Enables or disables instance hibernation capability.
    configured: ?bool = null,

    pub const json_field_names = .{
        .configured = "Configured",
    };
};
