/// Represents the `key:value` pair to be matched against given resource
/// property.
pub const ScanConditionPair = struct {
    /// Represents the **key** in the map condition.
    key: []const u8,

    /// Represents optional **value** in the map
    /// condition. If not specified, only the **key** will be
    /// matched.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
