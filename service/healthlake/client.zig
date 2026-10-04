const aws = @import("aws");
const std = @import("std");

const create_data_transformation_profile = @import("create_data_transformation_profile.zig");
const create_fhir_datastore = @import("create_fhir_datastore.zig");
const delete_data_transformation_profile = @import("delete_data_transformation_profile.zig");
const delete_fhir_datastore = @import("delete_fhir_datastore.zig");
const describe_data_transformation_job = @import("describe_data_transformation_job.zig");
const describe_fhir_datastore = @import("describe_fhir_datastore.zig");
const describe_fhir_export_job = @import("describe_fhir_export_job.zig");
const describe_fhir_import_job = @import("describe_fhir_import_job.zig");
const get_data_transformation_profile = @import("get_data_transformation_profile.zig");
const list_data_transformation_jobs = @import("list_data_transformation_jobs.zig");
const list_data_transformation_profile_versions = @import("list_data_transformation_profile_versions.zig");
const list_data_transformation_profiles = @import("list_data_transformation_profiles.zig");
const list_fhir_datastores = @import("list_fhir_datastores.zig");
const list_fhir_export_jobs = @import("list_fhir_export_jobs.zig");
const list_fhir_import_jobs = @import("list_fhir_import_jobs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const publish_data_transformation_profile = @import("publish_data_transformation_profile.zig");
const restore_fhir_datastore = @import("restore_fhir_datastore.zig");
const start_data_transformation_job = @import("start_data_transformation_job.zig");
const start_fhir_export_job = @import("start_fhir_export_job.zig");
const start_fhir_import_job = @import("start_fhir_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_data_transformation_profile = @import("update_data_transformation_profile.zig");
const update_fhir_datastore = @import("update_fhir_datastore.zig");
const update_profile_with_agent = @import("update_profile_with_agent.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "HealthLake";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Creates a data transformation profile in DRAFT state. Specify a built-in
    /// starter profile, an existing profile version, raw profile content, or a
    /// sample data file as the source.
    pub fn createDataTransformationProfile(self: *Self, allocator: std.mem.Allocator, input: create_data_transformation_profile.CreateDataTransformationProfileInput, options: CallOptions) !create_data_transformation_profile.CreateDataTransformationProfileOutput {
        return create_data_transformation_profile.execute(self, allocator, input, options);
    }

    /// Create a FHIR-enabled data store.
    pub fn createFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: create_fhir_datastore.CreateFHIRDatastoreInput, options: CallOptions) !create_fhir_datastore.CreateFHIRDatastoreOutput {
        return create_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Deletes a data transformation profile and all its versions, including the
    /// DRAFT and all published versions.
    pub fn deleteDataTransformationProfile(self: *Self, allocator: std.mem.Allocator, input: delete_data_transformation_profile.DeleteDataTransformationProfileInput, options: CallOptions) !delete_data_transformation_profile.DeleteDataTransformationProfileOutput {
        return delete_data_transformation_profile.execute(self, allocator, input, options);
    }

    /// Delete a FHIR-enabled data store.
    pub fn deleteFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: delete_fhir_datastore.DeleteFHIRDatastoreInput, options: CallOptions) !delete_fhir_datastore.DeleteFHIRDatastoreOutput {
        return delete_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Describes a data transformation job, including its current status,
    /// configuration, and progress information.
    pub fn describeDataTransformationJob(self: *Self, allocator: std.mem.Allocator, input: describe_data_transformation_job.DescribeDataTransformationJobInput, options: CallOptions) !describe_data_transformation_job.DescribeDataTransformationJobOutput {
        return describe_data_transformation_job.execute(self, allocator, input, options);
    }

    /// Get properties for a FHIR-enabled data store.
    pub fn describeFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: describe_fhir_datastore.DescribeFHIRDatastoreInput, options: CallOptions) !describe_fhir_datastore.DescribeFHIRDatastoreOutput {
        return describe_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Get FHIR export job properties.
    pub fn describeFhirExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_fhir_export_job.DescribeFHIRExportJobInput, options: CallOptions) !describe_fhir_export_job.DescribeFHIRExportJobOutput {
        return describe_fhir_export_job.execute(self, allocator, input, options);
    }

    /// Get the import job properties to learn more about the job or job progress.
    pub fn describeFhirImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_fhir_import_job.DescribeFHIRImportJobInput, options: CallOptions) !describe_fhir_import_job.DescribeFHIRImportJobOutput {
        return describe_fhir_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves a data transformation profile's metadata and profile content at a
    /// specific version. Specify version 0 to retrieve the DRAFT, a version number
    /// between 1 and 99 to retrieve a specific published version, or omit the
    /// version to retrieve the latest published version.
    pub fn getDataTransformationProfile(self: *Self, allocator: std.mem.Allocator, input: get_data_transformation_profile.GetDataTransformationProfileInput, options: CallOptions) !get_data_transformation_profile.GetDataTransformationProfileOutput {
        return get_data_transformation_profile.execute(self, allocator, input, options);
    }

    /// Lists data transformation jobs for your Amazon Web Services account. Results
    /// can be filtered by status, job name, and submit time window. Results are
    /// paginated. Use the `NextToken` parameter to retrieve additional results.
    pub fn listDataTransformationJobs(self: *Self, allocator: std.mem.Allocator, input: list_data_transformation_jobs.ListDataTransformationJobsInput, options: CallOptions) !list_data_transformation_jobs.ListDataTransformationJobsOutput {
        return list_data_transformation_jobs.execute(self, allocator, input, options);
    }

    /// Lists all versions of a specific data transformation profile (DRAFT and
    /// published), in reverse chronological order (newest first). Use
    /// `GetDataTransformationProfile` to retrieve profile content. Results are
    /// paginated. Use the `NextToken` parameter to retrieve additional results.
    pub fn listDataTransformationProfileVersions(self: *Self, allocator: std.mem.Allocator, input: list_data_transformation_profile_versions.ListDataTransformationProfileVersionsInput, options: CallOptions) !list_data_transformation_profile_versions.ListDataTransformationProfileVersionsOutput {
        return list_data_transformation_profile_versions.execute(self, allocator, input, options);
    }

    /// Lists all data transformation profiles in your account, returning the latest
    /// version summary for each. Use `GetDataTransformationProfile` to retrieve
    /// profile content. Results are paginated. Use the `NextToken` parameter to
    /// retrieve additional results.
    pub fn listDataTransformationProfiles(self: *Self, allocator: std.mem.Allocator, input: list_data_transformation_profiles.ListDataTransformationProfilesInput, options: CallOptions) !list_data_transformation_profiles.ListDataTransformationProfilesOutput {
        return list_data_transformation_profiles.execute(self, allocator, input, options);
    }

    /// List all FHIR-enabled data stores in a user’s account, regardless of data
    /// store status.
    pub fn listFhirDatastores(self: *Self, allocator: std.mem.Allocator, input: list_fhir_datastores.ListFHIRDatastoresInput, options: CallOptions) !list_fhir_datastores.ListFHIRDatastoresOutput {
        return list_fhir_datastores.execute(self, allocator, input, options);
    }

    /// Lists all FHIR export jobs associated with an account and their statuses.
    pub fn listFhirExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_fhir_export_jobs.ListFHIRExportJobsInput, options: CallOptions) !list_fhir_export_jobs.ListFHIRExportJobsOutput {
        return list_fhir_export_jobs.execute(self, allocator, input, options);
    }

    /// List all FHIR import jobs associated with an account and their statuses.
    pub fn listFhirImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_fhir_import_jobs.ListFHIRImportJobsInput, options: CallOptions) !list_fhir_import_jobs.ListFHIRImportJobsOutput {
        return list_fhir_import_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of all existing tags associated with a data store.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Promotes the current DRAFT version of a data transformation profile to a new
    /// immutable published version. Also supports rollback by publishing from a
    /// previously published version.
    pub fn publishDataTransformationProfile(self: *Self, allocator: std.mem.Allocator, input: publish_data_transformation_profile.PublishDataTransformationProfileInput, options: CallOptions) !publish_data_transformation_profile.PublishDataTransformationProfileOutput {
        return publish_data_transformation_profile.execute(self, allocator, input, options);
    }

    /// Restore a backup-enabled data store to a point in time. Creates a new data
    /// store from the backup.
    pub fn restoreFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: restore_fhir_datastore.RestoreFHIRDatastoreInput, options: CallOptions) !restore_fhir_datastore.RestoreFHIRDatastoreOutput {
        return restore_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous data transformation job that converts source files
    /// from Amazon Simple Storage Service (Amazon S3) and writes the output to
    /// Amazon S3 or HealthLake.
    pub fn startDataTransformationJob(self: *Self, allocator: std.mem.Allocator, input: start_data_transformation_job.StartDataTransformationJobInput, options: CallOptions) !start_data_transformation_job.StartDataTransformationJobOutput {
        return start_data_transformation_job.execute(self, allocator, input, options);
    }

    /// Start a FHIR export job.
    pub fn startFhirExportJob(self: *Self, allocator: std.mem.Allocator, input: start_fhir_export_job.StartFHIRExportJobInput, options: CallOptions) !start_fhir_export_job.StartFHIRExportJobOutput {
        return start_fhir_export_job.execute(self, allocator, input, options);
    }

    /// Start importing bulk FHIR data into an ACTIVE data store. The import job
    /// imports FHIR data found in the `InputDataConfig` object and stores
    /// processing results in the `JobOutputDataConfig` object.
    pub fn startFhirImportJob(self: *Self, allocator: std.mem.Allocator, input: start_fhir_import_job.StartFHIRImportJobInput, options: CallOptions) !start_fhir_import_job.StartFHIRImportJobOutput {
        return start_fhir_import_job.execute(self, allocator, input, options);
    }

    /// Add a user-specifed key and value tag to a data store.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove a user-specifed key and value tag from a data store.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the DRAFT version (version 0) of a data transformation profile with
    /// new profile content. The update replaces all existing DRAFT content.
    pub fn updateDataTransformationProfile(self: *Self, allocator: std.mem.Allocator, input: update_data_transformation_profile.UpdateDataTransformationProfileInput, options: CallOptions) !update_data_transformation_profile.UpdateDataTransformationProfileOutput {
        return update_data_transformation_profile.execute(self, allocator, input, options);
    }

    /// Update the properties of a FHIR-enabled data store.
    pub fn updateFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: update_fhir_datastore.UpdateFHIRDatastoreInput, options: CallOptions) !update_fhir_datastore.UpdateFHIRDatastoreOutput {
        return update_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Updates a data transformation profile using chat-based interaction with an
    /// agent. Supports multi-turn conversations for iteratively customizing
    /// profiles.
    pub fn updateProfileWithAgent(self: *Self, allocator: std.mem.Allocator, input: update_profile_with_agent.UpdateProfileWithAgentInput, options: CallOptions) !update_profile_with_agent.UpdateProfileWithAgentOutput {
        return update_profile_with_agent.execute(self, allocator, input, options);
    }

    pub fn listDataTransformationJobsPaginator(self: *Self, params: list_data_transformation_jobs.ListDataTransformationJobsInput) paginator.ListDataTransformationJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataTransformationProfileVersionsPaginator(self: *Self, params: list_data_transformation_profile_versions.ListDataTransformationProfileVersionsInput) paginator.ListDataTransformationProfileVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDataTransformationProfilesPaginator(self: *Self, params: list_data_transformation_profiles.ListDataTransformationProfilesInput) paginator.ListDataTransformationProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFhirDatastoresPaginator(self: *Self, params: list_fhir_datastores.ListFHIRDatastoresInput) paginator.ListFHIRDatastoresPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFhirExportJobsPaginator(self: *Self, params: list_fhir_export_jobs.ListFHIRExportJobsInput) paginator.ListFHIRExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFhirImportJobsPaginator(self: *Self, params: list_fhir_import_jobs.ListFHIRImportJobsInput) paginator.ListFHIRImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilDataTransformationJobCompleted(self: *Self, params: describe_data_transformation_job.DescribeDataTransformationJobInput) aws.waiter.WaiterError!void {
        var w = waiters.DataTransformationJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFHIRDatastoreActive(self: *Self, params: describe_fhir_datastore.DescribeFHIRDatastoreInput) aws.waiter.WaiterError!void {
        var w = waiters.FHIRDatastoreActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFHIRDatastoreDeleted(self: *Self, params: describe_fhir_datastore.DescribeFHIRDatastoreInput) aws.waiter.WaiterError!void {
        var w = waiters.FHIRDatastoreDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFHIRExportJobCompleted(self: *Self, params: describe_fhir_export_job.DescribeFHIRExportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.FHIRExportJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFHIRImportJobCompleted(self: *Self, params: describe_fhir_import_job.DescribeFHIRImportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.FHIRImportJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
