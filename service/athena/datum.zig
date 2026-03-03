/// A piece of data (a field in the table).
pub const Datum = struct {
    /// The value of the datum.
    var_char_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .var_char_value = "VarCharValue",
    };
};
