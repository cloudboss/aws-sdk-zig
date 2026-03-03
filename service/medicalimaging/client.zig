const aws = @import("aws");
const std = @import("std");

const copy_image_set = @import("copy_image_set.zig");
const create_datastore = @import("create_datastore.zig");
const delete_datastore = @import("delete_datastore.zig");
const delete_image_set = @import("delete_image_set.zig");
const get_datastore = @import("get_datastore.zig");
const get_dicom_import_job = @import("get_dicom_import_job.zig");
const get_image_frame = @import("get_image_frame.zig");
const get_image_set = @import("get_image_set.zig");
const get_image_set_metadata = @import("get_image_set_metadata.zig");
const list_datastores = @import("list_datastores.zig");
const list_dicom_import_jobs = @import("list_dicom_import_jobs.zig");
const list_image_set_versions = @import("list_image_set_versions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const search_image_sets = @import("search_image_sets.zig");
const start_dicom_import_job = @import("start_dicom_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_image_set_metadata = @import("update_image_set_metadata.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Medical Imaging";

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

    /// Copy an image set.
    pub fn copyImageSet(self: *Self, allocator: std.mem.Allocator, input: copy_image_set.CopyImageSetInput, options: copy_image_set.Options) !copy_image_set.CopyImageSetOutput {
        return copy_image_set.execute(self, allocator, input, options);
    }

    /// Create a data store.
    pub fn createDatastore(self: *Self, allocator: std.mem.Allocator, input: create_datastore.CreateDatastoreInput, options: create_datastore.Options) !create_datastore.CreateDatastoreOutput {
        return create_datastore.execute(self, allocator, input, options);
    }

    /// Delete a data store.
    ///
    /// Before a data store can be deleted, you must first delete all image sets
    /// within it.
    pub fn deleteDatastore(self: *Self, allocator: std.mem.Allocator, input: delete_datastore.DeleteDatastoreInput, options: delete_datastore.Options) !delete_datastore.DeleteDatastoreOutput {
        return delete_datastore.execute(self, allocator, input, options);
    }

    /// Delete an image set.
    pub fn deleteImageSet(self: *Self, allocator: std.mem.Allocator, input: delete_image_set.DeleteImageSetInput, options: delete_image_set.Options) !delete_image_set.DeleteImageSetOutput {
        return delete_image_set.execute(self, allocator, input, options);
    }

    /// Get data store properties.
    pub fn getDatastore(self: *Self, allocator: std.mem.Allocator, input: get_datastore.GetDatastoreInput, options: get_datastore.Options) !get_datastore.GetDatastoreOutput {
        return get_datastore.execute(self, allocator, input, options);
    }

    /// Get the import job properties to learn more about the job or job progress.
    ///
    /// The `jobStatus` refers to the execution of the import job. Therefore, an
    /// import job can return a `jobStatus` as `COMPLETED` even if validation issues
    /// are discovered during the import process. If a `jobStatus` returns as
    /// `COMPLETED`, we still recommend you review the output manifests written to
    /// S3, as they provide details on the success or failure of individual P10
    /// object imports.
    pub fn getDicomImportJob(self: *Self, allocator: std.mem.Allocator, input: get_dicom_import_job.GetDICOMImportJobInput, options: get_dicom_import_job.Options) !get_dicom_import_job.GetDICOMImportJobOutput {
        return get_dicom_import_job.execute(self, allocator, input, options);
    }

    /// Get an image frame (pixel data) for an image set.
    pub fn getImageFrame(self: *Self, allocator: std.mem.Allocator, input: get_image_frame.GetImageFrameInput, options: get_image_frame.Options) !get_image_frame.GetImageFrameOutput {
        return get_image_frame.execute(self, allocator, input, options);
    }

    /// Get image set properties.
    pub fn getImageSet(self: *Self, allocator: std.mem.Allocator, input: get_image_set.GetImageSetInput, options: get_image_set.Options) !get_image_set.GetImageSetOutput {
        return get_image_set.execute(self, allocator, input, options);
    }

    /// Get metadata attributes for an image set.
    pub fn getImageSetMetadata(self: *Self, allocator: std.mem.Allocator, input: get_image_set_metadata.GetImageSetMetadataInput, options: get_image_set_metadata.Options) !get_image_set_metadata.GetImageSetMetadataOutput {
        return get_image_set_metadata.execute(self, allocator, input, options);
    }

    /// List data stores.
    pub fn listDatastores(self: *Self, allocator: std.mem.Allocator, input: list_datastores.ListDatastoresInput, options: list_datastores.Options) !list_datastores.ListDatastoresOutput {
        return list_datastores.execute(self, allocator, input, options);
    }

    /// List import jobs created for a specific data store.
    pub fn listDicomImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_dicom_import_jobs.ListDICOMImportJobsInput, options: list_dicom_import_jobs.Options) !list_dicom_import_jobs.ListDICOMImportJobsOutput {
        return list_dicom_import_jobs.execute(self, allocator, input, options);
    }

    /// List image set versions.
    pub fn listImageSetVersions(self: *Self, allocator: std.mem.Allocator, input: list_image_set_versions.ListImageSetVersionsInput, options: list_image_set_versions.Options) !list_image_set_versions.ListImageSetVersionsOutput {
        return list_image_set_versions.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a medical imaging resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Search image sets based on defined input attributes.
    ///
    /// `SearchImageSets` accepts a single search query parameter and returns a
    /// paginated response of all image sets that have the matching criteria. All
    /// date range queries must be input as `(lowerBound, upperBound)`.
    ///
    /// By default, `SearchImageSets` uses the `updatedAt` field for sorting in
    /// descending order from newest to oldest.
    pub fn searchImageSets(self: *Self, allocator: std.mem.Allocator, input: search_image_sets.SearchImageSetsInput, options: search_image_sets.Options) !search_image_sets.SearchImageSetsOutput {
        return search_image_sets.execute(self, allocator, input, options);
    }

    /// Start importing bulk data into an `ACTIVE` data store. The import job
    /// imports DICOM P10 files found in the S3 prefix specified by the `inputS3Uri`
    /// parameter. The import job stores processing results in the file specified by
    /// the `outputS3Uri` parameter.
    pub fn startDicomImportJob(self: *Self, allocator: std.mem.Allocator, input: start_dicom_import_job.StartDICOMImportJobInput, options: start_dicom_import_job.Options) !start_dicom_import_job.StartDICOMImportJobOutput {
        return start_dicom_import_job.execute(self, allocator, input, options);
    }

    /// Adds a user-specifed key and value tag to a medical imaging resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a medical imaging resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update image set metadata attributes.
    pub fn updateImageSetMetadata(self: *Self, allocator: std.mem.Allocator, input: update_image_set_metadata.UpdateImageSetMetadataInput, options: update_image_set_metadata.Options) !update_image_set_metadata.UpdateImageSetMetadataOutput {
        return update_image_set_metadata.execute(self, allocator, input, options);
    }

    pub fn listDatastoresPaginator(self: *Self, params: list_datastores.ListDatastoresInput) paginator.ListDatastoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDicomImportJobsPaginator(self: *Self, params: list_dicom_import_jobs.ListDICOMImportJobsInput) paginator.ListDICOMImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImageSetVersionsPaginator(self: *Self, params: list_image_set_versions.ListImageSetVersionsInput) paginator.ListImageSetVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchImageSetsPaginator(self: *Self, params: search_image_sets.SearchImageSetsInput) paginator.SearchImageSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
