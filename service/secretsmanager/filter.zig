const FilterNameStringType = @import("filter_name_string_type.zig").FilterNameStringType;

/// Allows you to add filters when you use the search function in Secrets
/// Manager. For more
/// information, see [Find secrets in
/// Secrets
/// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_search-secret.html).
pub const Filter = struct {
    /// The following are keys you can use:
    ///
    /// * **description**: Prefix match, not
    /// case-sensitive.
    ///
    /// * **name**: Prefix match, case-sensitive.
    ///
    /// * **tag-key**: Prefix match, case-sensitive.
    ///
    /// * **tag-value**: Prefix match,
    /// case-sensitive.
    ///
    /// * **primary-region**: Prefix match,
    /// case-sensitive.
    ///
    /// * **owning-service**: Prefix match,
    /// case-sensitive.
    ///
    /// * **all**: Breaks the filter value string into
    /// words and then searches all attributes for matches. Not case-sensitive.
    key: ?FilterNameStringType,

    /// The keyword to filter for.
    ///
    /// You can prefix your search value with an exclamation mark (`!`) in order to
    /// perform negation filters.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
