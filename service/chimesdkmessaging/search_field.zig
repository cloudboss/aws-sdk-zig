const SearchFieldKey = @import("search_field_key.zig").SearchFieldKey;
const SearchFieldOperator = @import("search_field_operator.zig").SearchFieldOperator;

/// A `Field` of the channel that you want to search.
///
/// This operation isn't supported for `AppInstanceUsers` with a large number of
/// memberships.
pub const SearchField = struct {
    /// An `enum` value that indicates the key to search the channel on. `MEMBERS`
    /// allows you to search channels based on memberships. You can use it with the
    /// `EQUALS`
    /// operator to get channels whose memberships are equal to the specified
    /// values, and with the `INCLUDES` operator to get channels whose memberships
    /// include the specified values.
    key: SearchFieldKey,

    /// The operator used to compare field values, currently `EQUALS` or `INCLUDES`.
    /// Use the `EQUALS` operator to find channels whose memberships equal the
    /// specified values.
    /// Use the `INCLUDES` operator to find channels whose memberships include the
    /// specified values.
    operator: SearchFieldOperator,

    /// The values that you want to search for, a list of strings. The values must
    /// be `AppInstanceUserArns` specified as a list of strings.
    ///
    /// This operation isn't supported for `AppInstanceUsers` with a large number of
    /// memberships.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .operator = "Operator",
        .values = "Values",
    };
};
