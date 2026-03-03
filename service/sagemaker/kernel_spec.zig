/// The specification of a Jupyter kernel.
pub const KernelSpec = struct {
    /// The display name of the kernel.
    display_name: ?[]const u8 = null,

    /// The name of the Jupyter kernel in the image. This value is case sensitive.
    name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .name = "Name",
    };
};
