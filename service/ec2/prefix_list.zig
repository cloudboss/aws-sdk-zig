/// Describes prefixes for Amazon Web Services services.
pub const PrefixList = struct {
    /// The IP address range of the Amazon Web Services service.
    cidrs: ?[]const []const u8 = null,

    /// The ID of the prefix.
    prefix_list_id: ?[]const u8 = null,

    /// The name of the prefix.
    prefix_list_name: ?[]const u8 = null,
};
