const DescribePackagesFilterName = @import("describe_packages_filter_name.zig").DescribePackagesFilterName;

/// Filter to apply in `DescribePackage` response.
pub const DescribePackagesFilter = struct {
    /// Any field from `PackageDetails`.
    name: ?DescribePackagesFilterName,

    /// A non-empty list of values for the specified field.
    value: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
