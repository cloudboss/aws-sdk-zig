const ScanningRepositoryFilterType = @import("scanning_repository_filter_type.zig").ScanningRepositoryFilterType;

/// The details of a scanning repository filter. For more information on how to
/// use
/// filters, see [Using
/// filters](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html#image-scanning-filters) in the *Amazon Elastic Container Registry User Guide*.
pub const ScanningRepositoryFilter = struct {
    /// The filter to use when scanning.
    filter: []const u8,

    /// The type associated with the filter.
    filter_type: ScanningRepositoryFilterType,

    pub const json_field_names = .{
        .filter = "filter",
        .filter_type = "filterType",
    };
};
