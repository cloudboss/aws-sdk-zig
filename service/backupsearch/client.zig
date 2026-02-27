const aws = @import("aws");
const std = @import("std");

const get_search_job = @import("get_search_job.zig");
const get_search_result_export_job = @import("get_search_result_export_job.zig");
const list_search_job_backups = @import("list_search_job_backups.zig");
const list_search_job_results = @import("list_search_job_results.zig");
const list_search_jobs = @import("list_search_jobs.zig");
const list_search_result_export_jobs = @import("list_search_result_export_jobs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_search_job = @import("start_search_job.zig");
const start_search_result_export_job = @import("start_search_result_export_job.zig");
const stop_search_job = @import("stop_search_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "BackupSearch";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// This operation retrieves metadata of a search job, including its progress.
    pub fn getSearchJob(self: *Self, allocator: std.mem.Allocator, input: get_search_job.GetSearchJobInput, options: get_search_job.Options) !get_search_job.GetSearchJobOutput {
        return get_search_job.execute(self, allocator, input, options);
    }

    /// This operation retrieves the metadata of an export job.
    ///
    /// An export job is an operation that transmits the results of a search job to
    /// a specified S3 bucket in a .csv file.
    ///
    /// An export job allows you to retain results of a search beyond the search
    /// job's scheduled retention of 7 days.
    pub fn getSearchResultExportJob(self: *Self, allocator: std.mem.Allocator, input: get_search_result_export_job.GetSearchResultExportJobInput, options: get_search_result_export_job.Options) !get_search_result_export_job.GetSearchResultExportJobOutput {
        return get_search_result_export_job.execute(self, allocator, input, options);
    }

    /// This operation returns a list of all backups (recovery points) in a
    /// paginated format that were included in the search job.
    ///
    /// If a search does not display an expected backup in the results, you can call
    /// this operation to display each backup included in the search. Any backups
    /// that were not included because they have a `FAILED` status from a
    /// permissions issue will be displayed, along with a status message.
    ///
    /// Only recovery points with a backup index that has a status of `ACTIVE` will
    /// be included in search results. If the index has any other status, its status
    /// will be displayed along with a status message.
    pub fn listSearchJobBackups(self: *Self, allocator: std.mem.Allocator, input: list_search_job_backups.ListSearchJobBackupsInput, options: list_search_job_backups.Options) !list_search_job_backups.ListSearchJobBackupsOutput {
        return list_search_job_backups.execute(self, allocator, input, options);
    }

    /// This operation returns a list of a specified search job.
    pub fn listSearchJobResults(self: *Self, allocator: std.mem.Allocator, input: list_search_job_results.ListSearchJobResultsInput, options: list_search_job_results.Options) !list_search_job_results.ListSearchJobResultsOutput {
        return list_search_job_results.execute(self, allocator, input, options);
    }

    /// This operation returns a list of search jobs belonging to an account.
    pub fn listSearchJobs(self: *Self, allocator: std.mem.Allocator, input: list_search_jobs.ListSearchJobsInput, options: list_search_jobs.Options) !list_search_jobs.ListSearchJobsOutput {
        return list_search_jobs.execute(self, allocator, input, options);
    }

    /// This operation exports search results of a search job to a specified
    /// destination S3 bucket.
    pub fn listSearchResultExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_search_result_export_jobs.ListSearchResultExportJobsInput, options: list_search_result_export_jobs.Options) !list_search_result_export_jobs.ListSearchResultExportJobsOutput {
        return list_search_result_export_jobs.execute(self, allocator, input, options);
    }

    /// This operation returns the tags for a resource type.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// This operation creates a search job which returns recovery points filtered
    /// by SearchScope and items filtered by ItemFilters.
    ///
    /// You can optionally include ClientToken, EncryptionKeyArn, Name, and/or Tags.
    pub fn startSearchJob(self: *Self, allocator: std.mem.Allocator, input: start_search_job.StartSearchJobInput, options: start_search_job.Options) !start_search_job.StartSearchJobOutput {
        return start_search_job.execute(self, allocator, input, options);
    }

    /// This operations starts a job to export the results of search job to a
    /// designated S3 bucket.
    pub fn startSearchResultExportJob(self: *Self, allocator: std.mem.Allocator, input: start_search_result_export_job.StartSearchResultExportJobInput, options: start_search_result_export_job.Options) !start_search_result_export_job.StartSearchResultExportJobOutput {
        return start_search_result_export_job.execute(self, allocator, input, options);
    }

    /// This operations ends a search job.
    ///
    /// Only a search job with a status of `RUNNING` can be stopped.
    pub fn stopSearchJob(self: *Self, allocator: std.mem.Allocator, input: stop_search_job.StopSearchJobInput, options: stop_search_job.Options) !stop_search_job.StopSearchJobOutput {
        return stop_search_job.execute(self, allocator, input, options);
    }

    /// This operation puts tags on the resource you indicate.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// This operation removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listSearchJobBackupsPaginator(self: *Self, params: list_search_job_backups.ListSearchJobBackupsInput) paginator.ListSearchJobBackupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSearchJobResultsPaginator(self: *Self, params: list_search_job_results.ListSearchJobResultsInput) paginator.ListSearchJobResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSearchJobsPaginator(self: *Self, params: list_search_jobs.ListSearchJobsInput) paginator.ListSearchJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSearchResultExportJobsPaginator(self: *Self, params: list_search_result_export_jobs.ListSearchResultExportJobsInput) paginator.ListSearchResultExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
