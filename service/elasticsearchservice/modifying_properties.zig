const PropertyValueType = @import("property_value_type.zig").PropertyValueType;

/// Information about the domain properties that are currently being modified.
pub const ModifyingProperties = struct {
    /// The current value of the domain property that is being modified.
    active_value: ?[]const u8,

    /// The name of the property that is currently being modified.
    name: ?[]const u8,

    /// The value that the property that is currently being modified will eventually
    /// have.
    pending_value: ?[]const u8,

    /// The type of value that is currently being modified. Properties can have two
    /// types:
    ///
    /// * **PLAIN_TEXT**: Contain direct values such as "1", "True", or
    ///   "c5.large.search".
    ///
    /// * **STRINGIFIED_JSON**: Contain content in JSON format, such as
    ///   {"Enabled":"True"}".
    value_type: ?PropertyValueType,

    pub const json_field_names = .{
        .active_value = "ActiveValue",
        .name = "Name",
        .pending_value = "PendingValue",
        .value_type = "ValueType",
    };
};
