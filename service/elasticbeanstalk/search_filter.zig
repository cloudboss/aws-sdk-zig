/// Describes criteria to restrict a list of results.
///
/// For operators that apply a single value to the attribute, the filter is
/// evaluated as
/// follows: `Attribute Operator Values[1]`
///
/// Some operators, e.g. `in`, can apply multiple values. In this case, the
/// filter
/// is evaluated as a logical union (OR) of applications of the operator to the
/// attribute with
/// each one of the values: `(Attribute Operator Values[1]) OR (Attribute
/// Operator Values[2])
/// OR ...`
///
/// The valid values for attributes of `SearchFilter` depend on the API action.
/// For
/// valid values, see the reference page for the API action you're calling that
/// takes a
/// `SearchFilter` parameter.
pub const SearchFilter = struct {
    /// The result attribute to which the filter values are applied. Valid values
    /// vary by API
    /// action.
    attribute: ?[]const u8 = null,

    /// The operator to apply to the `Attribute` with each of the `Values`.
    /// Valid values vary by `Attribute`.
    operator: ?[]const u8 = null,

    /// The list of values applied to the `Attribute` and `Operator`
    /// attributes. Number of values and valid values vary by `Attribute`.
    values: ?[]const []const u8 = null,
};
