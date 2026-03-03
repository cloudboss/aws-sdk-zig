const DataPathType = @import("data_path_type.zig").DataPathType;

/// The data path that needs to be sorted.
pub const DataPathValue = struct {
    /// The type configuration of the field.
    data_path_type: ?DataPathType = null,

    /// The field ID of the field that needs to be sorted.
    field_id: ?[]const u8 = null,

    /// The actual value of the field that needs to be sorted.
    field_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_path_type = "DataPathType",
        .field_id = "FieldId",
        .field_value = "FieldValue",
    };
};
