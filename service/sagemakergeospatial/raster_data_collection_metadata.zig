const aws = @import("aws");

const Filter = @import("filter.zig").Filter;
const DataCollectionType = @import("data_collection_type.zig").DataCollectionType;

/// Response object containing details for a specific RasterDataCollection.
pub const RasterDataCollectionMetadata = struct {
    /// The Amazon Resource Name (ARN) of the raster data collection.
    arn: []const u8,

    /// A description of the raster data collection.
    description: []const u8,

    /// The description URL of the raster data collection.
    description_page_url: ?[]const u8 = null,

    /// The name of the raster data collection.
    name: []const u8,

    /// The list of filters supported by the raster data collection.
    supported_filters: []const Filter,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of raster data collection.
    @"type": DataCollectionType,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .description_page_url = "DescriptionPageUrl",
        .name = "Name",
        .supported_filters = "SupportedFilters",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
