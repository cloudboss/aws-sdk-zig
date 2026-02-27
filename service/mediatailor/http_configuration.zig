/// The HTTP configuration for the source location.
pub const HttpConfiguration = struct {
    /// The base URL for the source location host server. This string must include
    /// the protocol, such as **https://**.
    base_url: []const u8,

    pub const json_field_names = .{
        .base_url = "BaseUrl",
    };
};
