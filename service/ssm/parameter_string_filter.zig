/// One or more filters. Use a filter to return a more specific list of results.
pub const ParameterStringFilter = struct {
    /// The name of the filter.
    ///
    /// The `ParameterStringFilter` object is used by the DescribeParameters and
    /// GetParametersByPath API operations.
    /// However, not all of the pattern values listed for `Key` can be used with
    /// both
    /// operations.
    ///
    /// For `DescribeParameters`, all of the listed patterns are valid except
    /// `Label`.
    ///
    /// For `GetParametersByPath`, the following patterns listed for `Key`
    /// aren't valid: `tag`, `DataType`, `Name`, `Path`, and
    /// `Tier`.
    ///
    /// For examples of Amazon Web Services CLI commands demonstrating valid
    /// parameter filter constructions, see
    /// [Searching for Systems Manager
    /// parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-search.html) in the *Amazon Web Services Systems Manager User Guide*.
    key: []const u8,

    /// For all filters used with DescribeParameters, valid options include
    /// `Equals` and `BeginsWith`. The `Name` filter additionally
    /// supports the `Contains` option. (Exception: For filters using the key
    /// `Path`, valid options include `Recursive` and
    /// `OneLevel`.)
    ///
    /// For filters used with GetParametersByPath, valid options include
    /// `Equals` and `BeginsWith`. (Exception: For filters using
    /// `Label` as the Key name, the only valid option is `Equals`.)
    option: ?[]const u8,

    /// The value you want to search for.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .option = "Option",
        .values = "Values",
    };
};
