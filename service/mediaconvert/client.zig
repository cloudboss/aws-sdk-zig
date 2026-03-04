const aws = @import("aws");
const std = @import("std");

const associate_certificate = @import("associate_certificate.zig");
const cancel_job = @import("cancel_job.zig");
const create_job = @import("create_job.zig");
const create_job_template = @import("create_job_template.zig");
const create_preset = @import("create_preset.zig");
const create_queue = @import("create_queue.zig");
const create_resource_share = @import("create_resource_share.zig");
const delete_job_template = @import("delete_job_template.zig");
const delete_policy = @import("delete_policy.zig");
const delete_preset = @import("delete_preset.zig");
const delete_queue = @import("delete_queue.zig");
const describe_endpoints = @import("describe_endpoints.zig");
const disassociate_certificate = @import("disassociate_certificate.zig");
const get_job = @import("get_job.zig");
const get_job_template = @import("get_job_template.zig");
const get_jobs_query_results = @import("get_jobs_query_results.zig");
const get_policy = @import("get_policy.zig");
const get_preset = @import("get_preset.zig");
const get_queue = @import("get_queue.zig");
const list_job_templates = @import("list_job_templates.zig");
const list_jobs = @import("list_jobs.zig");
const list_presets = @import("list_presets.zig");
const list_queues = @import("list_queues.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_versions = @import("list_versions.zig");
const probe_ = @import("probe.zig");
const put_policy = @import("put_policy.zig");
const search_jobs = @import("search_jobs.zig");
const start_jobs_query = @import("start_jobs_query.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_job_template = @import("update_job_template.zig");
const update_preset = @import("update_preset.zig");
const update_queue = @import("update_queue.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaConvert";

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

    /// Associates an AWS Certificate Manager (ACM) Amazon Resource Name (ARN) with
    /// AWS Elemental MediaConvert.
    pub fn associateCertificate(self: *Self, allocator: std.mem.Allocator, input: associate_certificate.AssociateCertificateInput, options: CallOptions) !associate_certificate.AssociateCertificateOutput {
        return associate_certificate.execute(self, allocator, input, options);
    }

    /// Permanently cancel a job. Once you have canceled a job, you can't start it
    /// again.
    pub fn cancelJob(self: *Self, allocator: std.mem.Allocator, input: cancel_job.CancelJobInput, options: CallOptions) !cancel_job.CancelJobOutput {
        return cancel_job.execute(self, allocator, input, options);
    }

    /// Create a new transcoding job. For information about jobs and job settings,
    /// see the User Guide at
    /// http://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: CallOptions) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// Create a new job template. For information about job templates see the User
    /// Guide at http://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
    pub fn createJobTemplate(self: *Self, allocator: std.mem.Allocator, input: create_job_template.CreateJobTemplateInput, options: CallOptions) !create_job_template.CreateJobTemplateOutput {
        return create_job_template.execute(self, allocator, input, options);
    }

    /// Create a new preset. For information about job templates see the User Guide
    /// at http://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
    pub fn createPreset(self: *Self, allocator: std.mem.Allocator, input: create_preset.CreatePresetInput, options: CallOptions) !create_preset.CreatePresetOutput {
        return create_preset.execute(self, allocator, input, options);
    }

    /// Create a new transcoding queue. For information about queues, see Working
    /// With Queues in the User Guide at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-queues.html
    pub fn createQueue(self: *Self, allocator: std.mem.Allocator, input: create_queue.CreateQueueInput, options: CallOptions) !create_queue.CreateQueueOutput {
        return create_queue.execute(self, allocator, input, options);
    }

    /// Create a new resource share request for MediaConvert resources with AWS
    /// Support.
    pub fn createResourceShare(self: *Self, allocator: std.mem.Allocator, input: create_resource_share.CreateResourceShareInput, options: CallOptions) !create_resource_share.CreateResourceShareOutput {
        return create_resource_share.execute(self, allocator, input, options);
    }

    /// Permanently delete a job template you have created.
    pub fn deleteJobTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_job_template.DeleteJobTemplateInput, options: CallOptions) !delete_job_template.DeleteJobTemplateOutput {
        return delete_job_template.execute(self, allocator, input, options);
    }

    /// Permanently delete a policy that you created.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Permanently delete a preset you have created.
    pub fn deletePreset(self: *Self, allocator: std.mem.Allocator, input: delete_preset.DeletePresetInput, options: CallOptions) !delete_preset.DeletePresetOutput {
        return delete_preset.execute(self, allocator, input, options);
    }

    /// Permanently delete a queue you have created.
    pub fn deleteQueue(self: *Self, allocator: std.mem.Allocator, input: delete_queue.DeleteQueueInput, options: CallOptions) !delete_queue.DeleteQueueOutput {
        return delete_queue.execute(self, allocator, input, options);
    }

    /// Send a request with an empty body to the regional API endpoint to get your
    /// account API endpoint. Note that DescribeEndpoints is no longer required. We
    /// recommend that you send your requests directly to the regional endpoint
    /// instead.
    pub fn describeEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_endpoints.DescribeEndpointsInput, options: CallOptions) !describe_endpoints.DescribeEndpointsOutput {
        return describe_endpoints.execute(self, allocator, input, options);
    }

    /// Removes an association between the Amazon Resource Name (ARN) of an AWS
    /// Certificate Manager (ACM) certificate and an AWS Elemental MediaConvert
    /// resource.
    pub fn disassociateCertificate(self: *Self, allocator: std.mem.Allocator, input: disassociate_certificate.DisassociateCertificateInput, options: CallOptions) !disassociate_certificate.DisassociateCertificateOutput {
        return disassociate_certificate.execute(self, allocator, input, options);
    }

    /// Retrieve the JSON for a specific transcoding job.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: CallOptions) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Retrieve the JSON for a specific job template.
    pub fn getJobTemplate(self: *Self, allocator: std.mem.Allocator, input: get_job_template.GetJobTemplateInput, options: CallOptions) !get_job_template.GetJobTemplateOutput {
        return get_job_template.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array of up to twenty of your most recent jobs matched by a
    /// jobs query.
    pub fn getJobsQueryResults(self: *Self, allocator: std.mem.Allocator, input: get_jobs_query_results.GetJobsQueryResultsInput, options: CallOptions) !get_jobs_query_results.GetJobsQueryResultsOutput {
        return get_jobs_query_results.execute(self, allocator, input, options);
    }

    /// Retrieve the JSON for your policy.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieve the JSON for a specific preset.
    pub fn getPreset(self: *Self, allocator: std.mem.Allocator, input: get_preset.GetPresetInput, options: CallOptions) !get_preset.GetPresetOutput {
        return get_preset.execute(self, allocator, input, options);
    }

    /// Retrieve the JSON for a specific queue.
    pub fn getQueue(self: *Self, allocator: std.mem.Allocator, input: get_queue.GetQueueInput, options: CallOptions) !get_queue.GetQueueOutput {
        return get_queue.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array of up to twenty of your job templates. This will
    /// return the templates themselves, not just a list of them. To retrieve the
    /// next twenty templates, use the nextToken string returned with the array
    pub fn listJobTemplates(self: *Self, allocator: std.mem.Allocator, input: list_job_templates.ListJobTemplatesInput, options: CallOptions) !list_job_templates.ListJobTemplatesOutput {
        return list_job_templates.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array of up to twenty of your most recently created jobs.
    /// This array includes in-process, completed, and errored jobs. This will
    /// return the jobs themselves, not just a list of the jobs. To retrieve the
    /// twenty next most recent jobs, use the nextToken string returned with the
    /// array.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: CallOptions) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array of up to twenty of your presets. This will return the
    /// presets themselves, not just a list of them. To retrieve the next twenty
    /// presets, use the nextToken string returned with the array.
    pub fn listPresets(self: *Self, allocator: std.mem.Allocator, input: list_presets.ListPresetsInput, options: CallOptions) !list_presets.ListPresetsOutput {
        return list_presets.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array of up to twenty of your queues. This will return the
    /// queues themselves, not just a list of them. To retrieve the next twenty
    /// queues, use the nextToken string returned with the array.
    pub fn listQueues(self: *Self, allocator: std.mem.Allocator, input: list_queues.ListQueuesInput, options: CallOptions) !list_queues.ListQueuesOutput {
        return list_queues.execute(self, allocator, input, options);
    }

    /// Retrieve the tags for a MediaConvert resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array of all available Job engine versions and the date they
    /// expire.
    pub fn listVersions(self: *Self, allocator: std.mem.Allocator, input: list_versions.ListVersionsInput, options: CallOptions) !list_versions.ListVersionsOutput {
        return list_versions.execute(self, allocator, input, options);
    }

    /// Use Probe to obtain detailed information about your input media files. Probe
    /// returns a JSON that includes container, codec, frame rate, resolution, track
    /// count, audio layout, captions, and more. You can use this information to
    /// learn more about your media files, or to help make decisions while
    /// automating your transcoding workflow.
    pub fn probe(self: *Self, allocator: std.mem.Allocator, input: probe_.ProbeInput, options: CallOptions) !probe_.ProbeOutput {
        return probe_.execute(self, allocator, input, options);
    }

    /// Create or change your policy. For more information about policies, see the
    /// user guide at http://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
    pub fn putPolicy(self: *Self, allocator: std.mem.Allocator, input: put_policy.PutPolicyInput, options: CallOptions) !put_policy.PutPolicyOutput {
        return put_policy.execute(self, allocator, input, options);
    }

    /// Retrieve a JSON array that includes job details for up to twenty of your
    /// most recent jobs. Optionally filter results further according to input file,
    /// queue, or status. To retrieve the twenty next most recent jobs, use the
    /// nextToken string returned with the array.
    pub fn searchJobs(self: *Self, allocator: std.mem.Allocator, input: search_jobs.SearchJobsInput, options: CallOptions) !search_jobs.SearchJobsOutput {
        return search_jobs.execute(self, allocator, input, options);
    }

    /// Start an asynchronous jobs query using the provided filters. To receive the
    /// list of jobs that match your query, call the GetJobsQueryResults API using
    /// the query ID returned by this API.
    pub fn startJobsQuery(self: *Self, allocator: std.mem.Allocator, input: start_jobs_query.StartJobsQueryInput, options: CallOptions) !start_jobs_query.StartJobsQueryOutput {
        return start_jobs_query.execute(self, allocator, input, options);
    }

    /// Add tags to a MediaConvert queue, preset, or job template. For information
    /// about tagging, see the User Guide at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/tagging-resources.html
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove tags from a MediaConvert queue, preset, or job template. For
    /// information about tagging, see the User Guide at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/tagging-resources.html
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modify one of your existing job templates.
    pub fn updateJobTemplate(self: *Self, allocator: std.mem.Allocator, input: update_job_template.UpdateJobTemplateInput, options: CallOptions) !update_job_template.UpdateJobTemplateOutput {
        return update_job_template.execute(self, allocator, input, options);
    }

    /// Modify one of your existing presets.
    pub fn updatePreset(self: *Self, allocator: std.mem.Allocator, input: update_preset.UpdatePresetInput, options: CallOptions) !update_preset.UpdatePresetOutput {
        return update_preset.execute(self, allocator, input, options);
    }

    /// Modify one of your existing queues.
    pub fn updateQueue(self: *Self, allocator: std.mem.Allocator, input: update_queue.UpdateQueueInput, options: CallOptions) !update_queue.UpdateQueueOutput {
        return update_queue.execute(self, allocator, input, options);
    }

    pub fn describeEndpointsPaginator(self: *Self, params: describe_endpoints.DescribeEndpointsInput) paginator.DescribeEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobTemplatesPaginator(self: *Self, params: list_job_templates.ListJobTemplatesInput) paginator.ListJobTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPresetsPaginator(self: *Self, params: list_presets.ListPresetsInput) paginator.ListPresetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listQueuesPaginator(self: *Self, params: list_queues.ListQueuesInput) paginator.ListQueuesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listVersionsPaginator(self: *Self, params: list_versions.ListVersionsInput) paginator.ListVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchJobsPaginator(self: *Self, params: search_jobs.SearchJobsInput) paginator.SearchJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
