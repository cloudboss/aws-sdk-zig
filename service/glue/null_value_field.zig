const Datatype = @import("datatype.zig").Datatype;

/// Represents a custom null value such as a zeros or other value being used as
/// a null placeholder unique to the dataset.
pub const NullValueField = struct {
    /// The datatype of the value.
    datatype: Datatype,

    /// The value of the null placeholder.
    value: []const u8,

    pub const json_field_names = .{
        .datatype = "Datatype",
        .value = "Value",
    };
};
