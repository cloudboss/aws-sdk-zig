const OpsItemDataType = @import("ops_item_data_type.zig").OpsItemDataType;

/// An object that defines the value of the key and its type in the
/// OperationalData map.
pub const OpsItemDataValue = struct {
    /// The type of key-value pair. Valid types include `SearchableString` and
    /// `String`.
    @"type": ?OpsItemDataType,

    /// The value of the OperationalData key.
    value: ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
