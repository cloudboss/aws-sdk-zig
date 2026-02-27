const RasterDataCollectionQueryOutput = @import("raster_data_collection_query_output.zig").RasterDataCollectionQueryOutput;

/// The InputConfig for an EarthObservationJob response.
pub const InputConfigOutput = struct {
    /// The Amazon Resource Name (ARN) of the previous Earth Observation job.
    previous_earth_observation_job_arn: ?[]const u8,

    /// The structure representing the RasterDataCollection Query consisting of the
    /// Area of Interest,
    /// RasterDataCollectionArn, RasterDataCollectionName, TimeRange, and Property
    /// Filters.
    raster_data_collection_query: ?RasterDataCollectionQueryOutput,

    pub const json_field_names = .{
        .previous_earth_observation_job_arn = "PreviousEarthObservationJobArn",
        .raster_data_collection_query = "RasterDataCollectionQuery",
    };
};
