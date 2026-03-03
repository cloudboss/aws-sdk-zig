/// The list of supported product configurations that allow user-supplied
/// arguments. Amazon EMR accepts these arguments and forwards them to the
/// corresponding installation
/// script as bootstrap action arguments.
pub const SupportedProductConfig = struct {
    /// The list of user-supplied arguments.
    args: ?[]const []const u8 = null,

    /// The name of the product configuration.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .args = "Args",
        .name = "Name",
    };
};
