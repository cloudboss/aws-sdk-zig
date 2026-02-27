const LocationFilterName = @import("location_filter_name.zig").LocationFilterName;
const Operator = @import("operator.zig").Operator;

/// Narrow down the list of resources returned by `ListLocations`. For example,
/// to
/// see all your Amazon S3 locations, create a filter using `"Name":
/// "LocationType"`, `"Operator": "Equals"`, and `"Values":
/// "S3"`.
///
/// For more information, see [filtering
/// resources](https://docs.aws.amazon.com/datasync/latest/userguide/query-resources.html).
pub const LocationFilter = struct {
    /// The name of the filter being used. Each API call supports a list of filters
    /// that are
    /// available for it (for example, `LocationType` for
    /// `ListLocations`).
    name: LocationFilterName,

    /// The operator that is used to compare filter values (for example, `Equals` or
    /// `Contains`).
    operator: Operator,

    /// The values that you want to filter for. For example, you might want to
    /// display only Amazon
    /// S3 locations.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .values = "Values",
    };
};
