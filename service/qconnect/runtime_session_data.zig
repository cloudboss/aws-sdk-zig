const RuntimeSessionDataValue = @import("runtime_session_data_value.zig").RuntimeSessionDataValue;

/// The list of key-value pairs that are stored on the session.
pub const RuntimeSessionData = struct {
    /// The key of the data stored on the session.
    key: []const u8,

    /// The value of the data stored on the session.
    value: RuntimeSessionDataValue,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
