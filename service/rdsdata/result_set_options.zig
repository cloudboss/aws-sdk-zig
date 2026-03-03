const DecimalReturnType = @import("decimal_return_type.zig").DecimalReturnType;
const LongReturnType = @import("long_return_type.zig").LongReturnType;

/// Options that control how the result set is returned.
pub const ResultSetOptions = struct {
    /// A value that indicates how a field of `DECIMAL` type is represented
    /// in the response. The value of `STRING`, the default, specifies that
    /// it is converted to a String value. The value of `DOUBLE_OR_LONG`
    /// specifies that it is converted to a Long value if its scale is 0, or to a
    /// Double
    /// value otherwise.
    ///
    /// Conversion to Double or Long can result in roundoff errors due to precision
    /// loss.
    /// We recommend converting to String, especially when working with currency
    /// values.
    decimal_return_type: ?DecimalReturnType = null,

    /// A value that indicates how a field of `LONG` type is represented.
    /// Allowed values are `LONG` and `STRING`. The default
    /// is `LONG`. Specify `STRING` if the length or
    /// precision of numeric values might cause truncation or rounding errors.
    long_return_type: ?LongReturnType = null,

    pub const json_field_names = .{
        .decimal_return_type = "decimalReturnType",
        .long_return_type = "longReturnType",
    };
};
