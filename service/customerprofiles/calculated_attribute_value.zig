/// The object containing the values of a single calculated attribute value.
pub const CalculatedAttributeValue = struct {
    /// The unique name of the calculated attribute.
    calculated_attribute_name: ?[]const u8 = null,

    /// The display name of the calculated attribute.
    display_name: ?[]const u8 = null,

    /// Indicates whether the calculated attribute's value is based on partial data.
    /// If the data
    /// is partial, it is set to true.
    is_data_partial: ?[]const u8 = null,

    /// The timestamp of the newest object included in the calculated attribute
    /// calculation.
    last_object_timestamp: ?i64 = null,

    /// The profile id belonging to this calculated attribute value.
    profile_id: ?[]const u8 = null,

    /// The value of the calculated attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .calculated_attribute_name = "CalculatedAttributeName",
        .display_name = "DisplayName",
        .is_data_partial = "IsDataPartial",
        .last_object_timestamp = "LastObjectTimestamp",
        .profile_id = "ProfileId",
        .value = "Value",
    };
};
