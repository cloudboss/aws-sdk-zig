/// Each slot type can have a set of values. Each enumeration value
/// represents a value the slot type can take.
///
/// For example, a pizza ordering bot could have a slot type that
/// specifies the type of crust that the pizza should have. The slot type
/// could include the values
///
/// * thick
///
/// * thin
///
/// * stuffed
pub const EnumerationValue = struct {
    /// Additional values related to the slot type value.
    synonyms: ?[]const []const u8,

    /// The value of the slot type.
    value: []const u8,

    pub const json_field_names = .{
        .synonyms = "synonyms",
        .value = "value",
    };
};
