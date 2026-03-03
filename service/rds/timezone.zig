/// A time zone associated with a `DBInstance` or a `DBSnapshot`. This data type
/// is an element in the response to the `DescribeDBInstances`, the
/// `DescribeDBSnapshots`, and the `DescribeDBEngineVersions` actions.
pub const Timezone = struct {
    /// The name of the time zone.
    timezone_name: ?[]const u8 = null,
};
