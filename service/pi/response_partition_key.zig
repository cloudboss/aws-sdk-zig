const aws = @import("aws");

/// If `PartitionBy` was specified in a `DescribeDimensionKeys`
/// request, the dimensions are returned in an array. Each element in the array
/// specifies one
/// dimension.
pub const ResponsePartitionKey = struct {
    /// A dimension map that contains the dimensions for this partition.
    dimensions: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
    };
};
