const RasterDataCollectionQueryInput = @import("raster_data_collection_query_input.zig").RasterDataCollectionQueryInput;

/// Input configuration information.
pub const InputConfigInput = struct {
    /// The Amazon Resource Name (ARN) of the previous Earth Observation job.
    previous_earth_observation_job_arn: ?[]const u8,

    /// The structure representing the RasterDataCollection Query consisting of
    /// the Area of Interest, RasterDataCollectionArn,TimeRange and Property
    /// Filters.
    raster_data_collection_query: ?RasterDataCollectionQueryInput,

    pub const json_field_names = .{
        .previous_earth_observation_job_arn = "PreviousEarthObservationJobArn",
        .raster_data_collection_query = "RasterDataCollectionQuery",
    };
};
