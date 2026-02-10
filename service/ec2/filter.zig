/// A filter name and value pair that is used to return a more specific list of
/// results from a describe operation.
/// Filters can be used to match a set of resources by specific criteria, such
/// as tags, attributes, or IDs.
///
/// If you specify multiple filters, the filters are joined with an `AND`, and
/// the request returns only
/// results that match all of the specified filters.
///
/// For more information, see [List and filter using the CLI and
/// API](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Filtering.html#Filtering_Resources_CLI) in the *Amazon EC2 User Guide*.
pub const Filter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: ?[]const u8,

    /// The filter values. Filter values are case-sensitive. If you specify multiple
    /// values for a
    /// filter, the values are joined with an `OR`, and the request returns all
    /// results
    /// that match any of the specified values.
    values: ?[]const []const u8,
};
