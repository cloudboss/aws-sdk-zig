/// Configure Licensing.
pub const Licensing = struct {
    /// Configure BYOL OS licensing.
    os_byol: ?bool = null,

    pub const json_field_names = .{
        .os_byol = "osByol",
    };
};
