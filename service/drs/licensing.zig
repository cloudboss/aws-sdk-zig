/// Configuration of a machine's license.
pub const Licensing = struct {
    /// Whether to enable "Bring your own license" or not.
    os_byol: ?bool = null,

    pub const json_field_names = .{
        .os_byol = "osByol",
    };
};
