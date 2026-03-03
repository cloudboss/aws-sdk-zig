const aws = @import("aws");
const std = @import("std");

const create_fhir_datastore = @import("create_fhir_datastore.zig");
const delete_fhir_datastore = @import("delete_fhir_datastore.zig");
const describe_fhir_datastore = @import("describe_fhir_datastore.zig");
const describe_fhir_export_job = @import("describe_fhir_export_job.zig");
const describe_fhir_import_job = @import("describe_fhir_import_job.zig");
const list_fhir_datastores = @import("list_fhir_datastores.zig");
const list_fhir_export_jobs = @import("list_fhir_export_jobs.zig");
const list_fhir_import_jobs = @import("list_fhir_import_jobs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_fhir_export_job = @import("start_fhir_export_job.zig");
const start_fhir_import_job = @import("start_fhir_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "HealthLake";

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

    /// Create a FHIR-enabled data store.
    pub fn createFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: create_fhir_datastore.CreateFHIRDatastoreInput, options: create_fhir_datastore.Options) !create_fhir_datastore.CreateFHIRDatastoreOutput {
        return create_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Delete a FHIR-enabled data store.
    pub fn deleteFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: delete_fhir_datastore.DeleteFHIRDatastoreInput, options: delete_fhir_datastore.Options) !delete_fhir_datastore.DeleteFHIRDatastoreOutput {
        return delete_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Get properties for a FHIR-enabled data store.
    pub fn describeFhirDatastore(self: *Self, allocator: std.mem.Allocator, input: describe_fhir_datastore.DescribeFHIRDatastoreInput, options: describe_fhir_datastore.Options) !describe_fhir_datastore.DescribeFHIRDatastoreOutput {
        return describe_fhir_datastore.execute(self, allocator, input, options);
    }

    /// Get FHIR export job properties.
    pub fn describeFhirExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_fhir_export_job.DescribeFHIRExportJobInput, options: describe_fhir_export_job.Options) !describe_fhir_export_job.DescribeFHIRExportJobOutput {
        return describe_fhir_export_job.execute(self, allocator, input, options);
    }

    /// Get the import job properties to learn more about the job or job progress.
    pub fn describeFhirImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_fhir_import_job.DescribeFHIRImportJobInput, options: describe_fhir_import_job.Options) !describe_fhir_import_job.DescribeFHIRImportJobOutput {
        return describe_fhir_import_job.execute(self, allocator, input, options);
    }

    /// List all FHIR-enabled data stores in a user’s account, regardless of data
    /// store
    /// status.
    pub fn listFhirDatastores(self: *Self, allocator: std.mem.Allocator, input: list_fhir_datastores.ListFHIRDatastoresInput, options: list_fhir_datastores.Options) !list_fhir_datastores.ListFHIRDatastoresOutput {
        return list_fhir_datastores.execute(self, allocator, input, options);
    }

    /// Lists all FHIR export jobs associated with an account and their statuses.
    pub fn listFhirExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_fhir_export_jobs.ListFHIRExportJobsInput, options: list_fhir_export_jobs.Options) !list_fhir_export_jobs.ListFHIRExportJobsOutput {
        return list_fhir_export_jobs.execute(self, allocator, input, options);
    }

    /// List all FHIR import jobs associated with an account and their statuses.
    pub fn listFhirImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_fhir_import_jobs.ListFHIRImportJobsInput, options: list_fhir_import_jobs.Options) !list_fhir_import_jobs.ListFHIRImportJobsOutput {
        return list_fhir_import_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of all existing tags associated with a data store.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Start a FHIR export job.
    pub fn startFhirExportJob(self: *Self, allocator: std.mem.Allocator, input: start_fhir_export_job.StartFHIRExportJobInput, options: start_fhir_export_job.Options) !start_fhir_export_job.StartFHIRExportJobOutput {
        return start_fhir_export_job.execute(self, allocator, input, options);
    }

    /// Start importing bulk FHIR data into an ACTIVE data store. The import job
    /// imports FHIR
    /// data found in the `InputDataConfig` object and stores processing results in
    /// the
    /// `JobOutputDataConfig` object.
    pub fn startFhirImportJob(self: *Self, allocator: std.mem.Allocator, input: start_fhir_import_job.StartFHIRImportJobInput, options: start_fhir_import_job.Options) !start_fhir_import_job.StartFHIRImportJobOutput {
        return start_fhir_import_job.execute(self, allocator, input, options);
    }

    /// Add a user-specifed key and value tag to a data store.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove a user-specifed key and value tag from a data store.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listFhirDatastoresPaginator(self: *Self, params: list_fhir_datastores.ListFHIRDatastoresInput) paginator.ListFHIRDatastoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFhirExportJobsPaginator(self: *Self, params: list_fhir_export_jobs.ListFHIRExportJobsInput) paginator.ListFHIRExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFhirImportJobsPaginator(self: *Self, params: list_fhir_import_jobs.ListFHIRImportJobsInput) paginator.ListFHIRImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
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
