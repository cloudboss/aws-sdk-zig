const DescribePackagesFilterName = @import("describe_packages_filter_name.zig").DescribePackagesFilterName;

/// A filter to apply to the `DescribePackage` response.
pub const DescribePackagesFilter = struct {
    /// Any field from `PackageDetails`.
    name: ?DescribePackagesFilterName = null,

    /// A non-empty list of values for the specified filter field.
    value: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
