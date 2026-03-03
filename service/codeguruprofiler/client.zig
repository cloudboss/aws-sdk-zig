const aws = @import("aws");
const std = @import("std");

const add_notification_channels = @import("add_notification_channels.zig");
const batch_get_frame_metric_data = @import("batch_get_frame_metric_data.zig");
const configure_agent = @import("configure_agent.zig");
const create_profiling_group = @import("create_profiling_group.zig");
const delete_profiling_group = @import("delete_profiling_group.zig");
const describe_profiling_group = @import("describe_profiling_group.zig");
const get_findings_report_account_summary = @import("get_findings_report_account_summary.zig");
const get_notification_configuration = @import("get_notification_configuration.zig");
const get_policy = @import("get_policy.zig");
const get_profile = @import("get_profile.zig");
const get_recommendations = @import("get_recommendations.zig");
const list_findings_reports = @import("list_findings_reports.zig");
const list_profile_times = @import("list_profile_times.zig");
const list_profiling_groups = @import("list_profiling_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const post_agent_profile = @import("post_agent_profile.zig");
const put_permission = @import("put_permission.zig");
const remove_notification_channel = @import("remove_notification_channel.zig");
const remove_permission = @import("remove_permission.zig");
const submit_feedback = @import("submit_feedback.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_profiling_group = @import("update_profiling_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeGuruProfiler";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Add up to 2 anomaly notifications channels for a profiling group.
    pub fn addNotificationChannels(self: *Self, allocator: std.mem.Allocator, input: add_notification_channels.AddNotificationChannelsInput, options: add_notification_channels.Options) !add_notification_channels.AddNotificationChannelsOutput {
        return add_notification_channels.execute(self, allocator, input, options);
    }

    /// Returns the time series of values for a requested list
    /// of frame metrics from a time period.
    pub fn batchGetFrameMetricData(self: *Self, allocator: std.mem.Allocator, input: batch_get_frame_metric_data.BatchGetFrameMetricDataInput, options: batch_get_frame_metric_data.Options) !batch_get_frame_metric_data.BatchGetFrameMetricDataOutput {
        return batch_get_frame_metric_data.execute(self, allocator, input, options);
    }

    /// Used by profiler agents to report their current state and to receive remote
    /// configuration updates. For example, `ConfigureAgent` can be used
    /// to tell an agent whether to profile or not and for how long to return
    /// profiling data.
    pub fn configureAgent(self: *Self, allocator: std.mem.Allocator, input: configure_agent.ConfigureAgentInput, options: configure_agent.Options) !configure_agent.ConfigureAgentOutput {
        return configure_agent.execute(self, allocator, input, options);
    }

    /// Creates a profiling group.
    pub fn createProfilingGroup(self: *Self, allocator: std.mem.Allocator, input: create_profiling_group.CreateProfilingGroupInput, options: create_profiling_group.Options) !create_profiling_group.CreateProfilingGroupOutput {
        return create_profiling_group.execute(self, allocator, input, options);
    }

    /// Deletes a profiling group.
    pub fn deleteProfilingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_profiling_group.DeleteProfilingGroupInput, options: delete_profiling_group.Options) !delete_profiling_group.DeleteProfilingGroupOutput {
        return delete_profiling_group.execute(self, allocator, input, options);
    }

    /// Returns a [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// object that contains information about the requested profiling group.
    pub fn describeProfilingGroup(self: *Self, allocator: std.mem.Allocator, input: describe_profiling_group.DescribeProfilingGroupInput, options: describe_profiling_group.Options) !describe_profiling_group.DescribeProfilingGroupOutput {
        return describe_profiling_group.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [
    /// `FindingsReportSummary`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_FindingsReportSummary.html)
    /// objects that contain analysis results for all profiling groups in your AWS
    /// account.
    pub fn getFindingsReportAccountSummary(self: *Self, allocator: std.mem.Allocator, input: get_findings_report_account_summary.GetFindingsReportAccountSummaryInput, options: get_findings_report_account_summary.Options) !get_findings_report_account_summary.GetFindingsReportAccountSummaryOutput {
        return get_findings_report_account_summary.execute(self, allocator, input, options);
    }

    /// Get the current configuration for anomaly notifications for a profiling
    /// group.
    pub fn getNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_notification_configuration.GetNotificationConfigurationInput, options: get_notification_configuration.Options) !get_notification_configuration.GetNotificationConfigurationOutput {
        return get_notification_configuration.execute(self, allocator, input, options);
    }

    /// Returns the JSON-formatted resource-based policy on a profiling group.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: get_policy.Options) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Gets the aggregated profile of a profiling group for a specified time range.
    /// Amazon CodeGuru Profiler collects posted agent profiles for a profiling
    /// group
    /// into aggregated profiles.
    ///
    /// Because aggregated profiles expire over time `GetProfile` is not idempotent.
    ///
    /// Specify the time range for the requested aggregated profile using 1 or 2 of
    /// the following parameters: `startTime`,
    /// `endTime`, `period`. The maximum time range allowed is 7 days. If you
    /// specify all 3 parameters,
    /// an exception is thrown. If you specify only `period`, the latest aggregated
    /// profile is returned.
    ///
    /// Aggregated profiles are available with aggregation periods of 5 minutes, 1
    /// hour, and 1 day, aligned to
    /// UTC. The aggregation period of an aggregated profile determines how long it
    /// is retained. For more
    /// information, see [
    /// `AggregatedProfileTime`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_AggregatedProfileTime.html). The aggregated profile's aggregation period determines how long
    /// it is retained by CodeGuru Profiler.
    ///
    /// * If the aggregation period is 5 minutes, the aggregated profile is retained
    ///   for 15 days.
    ///
    /// * If the aggregation period is 1 hour, the aggregated profile is retained
    ///   for 60 days.
    ///
    /// * If the aggregation period is 1 day, the aggregated profile is retained for
    ///   3 years.
    ///
    /// There are two use cases for calling `GetProfile`.
    ///
    /// * If you want to return an aggregated profile that already exists, use
    /// [
    /// `ListProfileTimes`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ListProfileTimes.html) to
    /// view the time ranges of existing aggregated profiles. Use them in a
    /// `GetProfile` request to return a specific,
    /// existing aggregated profile.
    ///
    /// * If you want to return an aggregated profile for a time range that doesn't
    ///   align with an existing aggregated profile,
    /// then CodeGuru Profiler makes a best effort to combine existing aggregated
    /// profiles from the requested time
    /// range and return them as one aggregated profile.
    ///
    /// If aggregated profiles do not exist for the full time range requested, then
    /// aggregated profiles for a smaller time range are returned. For example, if
    /// the
    /// requested time range is from 00:00 to 00:20, and the existing aggregated
    /// profiles are
    /// from 00:15 and 00:25, then the aggregated profiles from 00:15 to 00:20 are
    /// returned.
    pub fn getProfile(self: *Self, allocator: std.mem.Allocator, input: get_profile.GetProfileInput, options: get_profile.Options) !get_profile.GetProfileOutput {
        return get_profile.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [
    /// `Recommendation`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_Recommendation.html)
    /// objects that contain recommendations for a profiling group for a given time
    /// period. A list of
    /// [
    /// `Anomaly`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_Anomaly.html)
    /// objects that contains details about anomalies detected in the profiling
    /// group for the same time period is also
    /// returned.
    pub fn getRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_recommendations.GetRecommendationsInput, options: get_recommendations.Options) !get_recommendations.GetRecommendationsOutput {
        return get_recommendations.execute(self, allocator, input, options);
    }

    /// List the available reports for a given profiling group and time range.
    pub fn listFindingsReports(self: *Self, allocator: std.mem.Allocator, input: list_findings_reports.ListFindingsReportsInput, options: list_findings_reports.Options) !list_findings_reports.ListFindingsReportsOutput {
        return list_findings_reports.execute(self, allocator, input, options);
    }

    /// Lists the start times of the available aggregated profiles of a profiling
    /// group
    /// for an aggregation period within the specified time range.
    pub fn listProfileTimes(self: *Self, allocator: std.mem.Allocator, input: list_profile_times.ListProfileTimesInput, options: list_profile_times.Options) !list_profile_times.ListProfileTimesOutput {
        return list_profile_times.execute(self, allocator, input, options);
    }

    /// Returns a list of profiling groups. The profiling groups are returned as
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// objects.
    pub fn listProfilingGroups(self: *Self, allocator: std.mem.Allocator, input: list_profiling_groups.ListProfilingGroupsInput, options: list_profiling_groups.Options) !list_profiling_groups.ListProfilingGroupsOutput {
        return list_profiling_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags that are assigned to a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Submits profiling data to an aggregated profile of a profiling group. To get
    /// an
    /// aggregated profile that is created with this profiling data, use
    /// [
    /// `GetProfile`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_GetProfile.html).
    pub fn postAgentProfile(self: *Self, allocator: std.mem.Allocator, input: post_agent_profile.PostAgentProfileInput, options: post_agent_profile.Options) !post_agent_profile.PostAgentProfileOutput {
        return post_agent_profile.execute(self, allocator, input, options);
    }

    /// Adds permissions to a profiling group's resource-based policy
    /// that are provided using an action group. If a profiling group doesn't have
    /// a resource-based policy, one is created for it using the permissions in the
    /// action group and
    /// the roles and users in the `principals` parameter.
    ///
    /// The one supported action group that can be added is `agentPermission`
    /// which grants `ConfigureAgent` and `PostAgent` permissions. For
    /// more information, see [Resource-based
    /// policies in CodeGuru
    /// Profiler](https://docs.aws.amazon.com/codeguru/latest/profiler-ug/resource-based-policies.html) in the *Amazon CodeGuru Profiler User
    /// Guide*, [
    /// `ConfigureAgent`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ConfigureAgent.html), and [
    /// `PostAgentProfile`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_PostAgentProfile.html).
    ///
    /// The first time you call `PutPermission` on a profiling group, do not specify
    /// a `revisionId` because
    /// it doesn't have a resource-based policy. Subsequent calls must provide a
    /// `revisionId` to specify
    /// which revision of the resource-based policy to add the permissions to.
    ///
    /// The response contains the profiling group's JSON-formatted resource policy.
    pub fn putPermission(self: *Self, allocator: std.mem.Allocator, input: put_permission.PutPermissionInput, options: put_permission.Options) !put_permission.PutPermissionOutput {
        return put_permission.execute(self, allocator, input, options);
    }

    /// Remove one anomaly notifications channel for a profiling group.
    pub fn removeNotificationChannel(self: *Self, allocator: std.mem.Allocator, input: remove_notification_channel.RemoveNotificationChannelInput, options: remove_notification_channel.Options) !remove_notification_channel.RemoveNotificationChannelOutput {
        return remove_notification_channel.execute(self, allocator, input, options);
    }

    /// Removes permissions from a profiling group's resource-based policy that are
    /// provided
    /// using an action group. The one supported action group that can be removed is
    /// `agentPermission` which grants `ConfigureAgent` and
    /// `PostAgent` permissions. For more information, see [Resource-based policies
    /// in CodeGuru
    /// Profiler](https://docs.aws.amazon.com/codeguru/latest/profiler-ug/resource-based-policies.html) in the *Amazon
    /// CodeGuru Profiler User Guide*, [
    /// `ConfigureAgent`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ConfigureAgent.html), and [
    /// `PostAgentProfile`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_PostAgentProfile.html).
    pub fn removePermission(self: *Self, allocator: std.mem.Allocator, input: remove_permission.RemovePermissionInput, options: remove_permission.Options) !remove_permission.RemovePermissionOutput {
        return remove_permission.execute(self, allocator, input, options);
    }

    /// Sends feedback to CodeGuru Profiler about whether the anomaly detected by
    /// the analysis is
    /// useful or not.
    pub fn submitFeedback(self: *Self, allocator: std.mem.Allocator, input: submit_feedback.SubmitFeedbackInput, options: submit_feedback.Options) !submit_feedback.SubmitFeedbackOutput {
        return submit_feedback.execute(self, allocator, input, options);
    }

    /// Use to assign one or more tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Use to remove one or more tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a profiling group.
    pub fn updateProfilingGroup(self: *Self, allocator: std.mem.Allocator, input: update_profiling_group.UpdateProfilingGroupInput, options: update_profiling_group.Options) !update_profiling_group.UpdateProfilingGroupOutput {
        return update_profiling_group.execute(self, allocator, input, options);
    }

    pub fn getFindingsReportAccountSummaryPaginator(self: *Self, params: get_findings_report_account_summary.GetFindingsReportAccountSummaryInput) paginator.GetFindingsReportAccountSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFindingsReportsPaginator(self: *Self, params: list_findings_reports.ListFindingsReportsInput) paginator.ListFindingsReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProfileTimesPaginator(self: *Self, params: list_profile_times.ListProfileTimesInput) paginator.ListProfileTimesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProfilingGroupsPaginator(self: *Self, params: list_profiling_groups.ListProfilingGroupsInput) paginator.ListProfilingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
