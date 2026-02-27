const TypeHint = @import("type_hint.zig").TypeHint;
const Field = @import("field.zig").Field;

/// A parameter used in a SQL statement.
pub const SqlParameter = struct {
    /// The name of the parameter.
    name: ?[]const u8,

    /// A hint that specifies the correct object type for data type mapping.
    /// Possible values
    /// are as follows:
    ///
    /// * `DATE` - The corresponding `String` parameter value is sent as an object
    /// of `DATE` type to the database. The accepted format is `YYYY-MM-DD`.
    ///
    /// * `DECIMAL` - The corresponding `String` parameter value is sent as an
    ///   object
    /// of `DECIMAL` type to the database.
    ///
    /// * `JSON` - The corresponding `String` parameter value is sent as an
    /// object of `JSON` type to the database.
    ///
    /// * `TIME` - The corresponding `String` parameter value is sent as an object
    /// of `TIME` type to the database. The accepted format is `HH:MM:SS[.FFF]`.
    ///
    /// * `TIMESTAMP` - The corresponding `String` parameter value is sent as an
    ///   object
    /// of `TIMESTAMP` type to the database. The accepted format is `YYYY-MM-DD
    /// HH:MM:SS[.FFF]`.
    ///
    /// * `UUID` - The corresponding `String` parameter value is sent as an object
    ///   of
    /// `UUID` type to the database.
    type_hint: ?TypeHint,

    /// The value of the parameter.
    value: ?Field,

    pub const json_field_names = .{
        .name = "name",
        .type_hint = "typeHint",
        .value = "value",
    };
};
