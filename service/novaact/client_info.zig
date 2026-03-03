/// Information about the client making API requests, used for compatibility
/// checking.
pub const ClientInfo = struct {
    /// The compatibility version of the client, used to ensure API compatibility.
    compatibility_version: i32,

    /// The version of the SDK being used by the client.
    sdk_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .compatibility_version = "compatibilityVersion",
        .sdk_version = "sdkVersion",
    };
};
