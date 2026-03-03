const aws = @import("aws");
const std = @import("std");

const delete_earth_observation_job = @import("delete_earth_observation_job.zig");
const delete_vector_enrichment_job = @import("delete_vector_enrichment_job.zig");
const export_earth_observation_job = @import("export_earth_observation_job.zig");
const export_vector_enrichment_job = @import("export_vector_enrichment_job.zig");
const get_earth_observation_job = @import("get_earth_observation_job.zig");
const get_raster_data_collection = @import("get_raster_data_collection.zig");
const get_tile = @import("get_tile.zig");
const get_vector_enrichment_job = @import("get_vector_enrichment_job.zig");
const list_earth_observation_jobs = @import("list_earth_observation_jobs.zig");
const list_raster_data_collections = @import("list_raster_data_collections.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_vector_enrichment_jobs = @import("list_vector_enrichment_jobs.zig");
const search_raster_data_collection = @import("search_raster_data_collection.zig");
const start_earth_observation_job = @import("start_earth_observation_job.zig");
const start_vector_enrichment_job = @import("start_vector_enrichment_job.zig");
const stop_earth_observation_job = @import("stop_earth_observation_job.zig");
const stop_vector_enrichment_job = @import("stop_vector_enrichment_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker Geospatial";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Use this operation to delete an Earth Observation job.
    pub fn deleteEarthObservationJob(self: *Self, allocator: std.mem.Allocator, input: delete_earth_observation_job.DeleteEarthObservationJobInput, options: CallOptions) !delete_earth_observation_job.DeleteEarthObservationJobOutput {
        return delete_earth_observation_job.execute(self, allocator, input, options);
    }

    /// Use this operation to delete a Vector Enrichment job.
    pub fn deleteVectorEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: delete_vector_enrichment_job.DeleteVectorEnrichmentJobInput, options: CallOptions) !delete_vector_enrichment_job.DeleteVectorEnrichmentJobOutput {
        return delete_vector_enrichment_job.execute(self, allocator, input, options);
    }

    /// Use this operation to export results of an Earth Observation job and
    /// optionally source images used as input to the EOJ to an Amazon S3 location.
    pub fn exportEarthObservationJob(self: *Self, allocator: std.mem.Allocator, input: export_earth_observation_job.ExportEarthObservationJobInput, options: CallOptions) !export_earth_observation_job.ExportEarthObservationJobOutput {
        return export_earth_observation_job.execute(self, allocator, input, options);
    }

    /// Use this operation to copy results of a Vector Enrichment job to an Amazon
    /// S3 location.
    pub fn exportVectorEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: export_vector_enrichment_job.ExportVectorEnrichmentJobInput, options: CallOptions) !export_vector_enrichment_job.ExportVectorEnrichmentJobOutput {
        return export_vector_enrichment_job.execute(self, allocator, input, options);
    }

    /// Get the details for a previously initiated Earth Observation job.
    pub fn getEarthObservationJob(self: *Self, allocator: std.mem.Allocator, input: get_earth_observation_job.GetEarthObservationJobInput, options: CallOptions) !get_earth_observation_job.GetEarthObservationJobOutput {
        return get_earth_observation_job.execute(self, allocator, input, options);
    }

    /// Use this operation to get details of a specific raster data collection.
    pub fn getRasterDataCollection(self: *Self, allocator: std.mem.Allocator, input: get_raster_data_collection.GetRasterDataCollectionInput, options: CallOptions) !get_raster_data_collection.GetRasterDataCollectionOutput {
        return get_raster_data_collection.execute(self, allocator, input, options);
    }

    /// Gets a web mercator tile for the given Earth Observation job.
    pub fn getTile(self: *Self, allocator: std.mem.Allocator, input: get_tile.GetTileInput, options: CallOptions) !get_tile.GetTileOutput {
        return get_tile.execute(self, allocator, input, options);
    }

    /// Retrieves details of a Vector Enrichment Job for a given job Amazon Resource
    /// Name (ARN).
    pub fn getVectorEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: get_vector_enrichment_job.GetVectorEnrichmentJobInput, options: CallOptions) !get_vector_enrichment_job.GetVectorEnrichmentJobOutput {
        return get_vector_enrichment_job.execute(self, allocator, input, options);
    }

    /// Use this operation to get a list of the Earth Observation jobs associated
    /// with the calling Amazon Web Services account.
    pub fn listEarthObservationJobs(self: *Self, allocator: std.mem.Allocator, input: list_earth_observation_jobs.ListEarthObservationJobsInput, options: CallOptions) !list_earth_observation_jobs.ListEarthObservationJobsOutput {
        return list_earth_observation_jobs.execute(self, allocator, input, options);
    }

    /// Use this operation to get raster data collections.
    pub fn listRasterDataCollections(self: *Self, allocator: std.mem.Allocator, input: list_raster_data_collections.ListRasterDataCollectionsInput, options: CallOptions) !list_raster_data_collections.ListRasterDataCollectionsOutput {
        return list_raster_data_collections.execute(self, allocator, input, options);
    }

    /// Lists the tags attached to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of vector enrichment jobs.
    pub fn listVectorEnrichmentJobs(self: *Self, allocator: std.mem.Allocator, input: list_vector_enrichment_jobs.ListVectorEnrichmentJobsInput, options: CallOptions) !list_vector_enrichment_jobs.ListVectorEnrichmentJobsOutput {
        return list_vector_enrichment_jobs.execute(self, allocator, input, options);
    }

    /// Allows you run image query on a specific raster data collection to get a
    /// list of the satellite imagery matching the selected filters.
    pub fn searchRasterDataCollection(self: *Self, allocator: std.mem.Allocator, input: search_raster_data_collection.SearchRasterDataCollectionInput, options: CallOptions) !search_raster_data_collection.SearchRasterDataCollectionOutput {
        return search_raster_data_collection.execute(self, allocator, input, options);
    }

    /// Use this operation to create an Earth observation job.
    pub fn startEarthObservationJob(self: *Self, allocator: std.mem.Allocator, input: start_earth_observation_job.StartEarthObservationJobInput, options: CallOptions) !start_earth_observation_job.StartEarthObservationJobOutput {
        return start_earth_observation_job.execute(self, allocator, input, options);
    }

    /// Creates a Vector Enrichment job for the supplied job type. Currently, there
    /// are two supported job types: reverse geocoding and map matching.
    pub fn startVectorEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: start_vector_enrichment_job.StartVectorEnrichmentJobInput, options: CallOptions) !start_vector_enrichment_job.StartVectorEnrichmentJobOutput {
        return start_vector_enrichment_job.execute(self, allocator, input, options);
    }

    /// Use this operation to stop an existing earth observation job.
    pub fn stopEarthObservationJob(self: *Self, allocator: std.mem.Allocator, input: stop_earth_observation_job.StopEarthObservationJobInput, options: CallOptions) !stop_earth_observation_job.StopEarthObservationJobOutput {
        return stop_earth_observation_job.execute(self, allocator, input, options);
    }

    /// Stops the Vector Enrichment job for a given job ARN.
    pub fn stopVectorEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: stop_vector_enrichment_job.StopVectorEnrichmentJobInput, options: CallOptions) !stop_vector_enrichment_job.StopVectorEnrichmentJobOutput {
        return stop_vector_enrichment_job.execute(self, allocator, input, options);
    }

    /// The resource you want to tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// The resource you want to untag.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listEarthObservationJobsPaginator(self: *Self, params: list_earth_observation_jobs.ListEarthObservationJobsInput) paginator.ListEarthObservationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRasterDataCollectionsPaginator(self: *Self, params: list_raster_data_collections.ListRasterDataCollectionsInput) paginator.ListRasterDataCollectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVectorEnrichmentJobsPaginator(self: *Self, params: list_vector_enrichment_jobs.ListVectorEnrichmentJobsInput) paginator.ListVectorEnrichmentJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchRasterDataCollectionPaginator(self: *Self, params: search_raster_data_collection.SearchRasterDataCollectionInput) paginator.SearchRasterDataCollectionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
