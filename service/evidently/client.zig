const aws = @import("aws");
const std = @import("std");

const batch_evaluate_feature = @import("batch_evaluate_feature.zig");
const create_experiment = @import("create_experiment.zig");
const create_feature = @import("create_feature.zig");
const create_launch = @import("create_launch.zig");
const create_project = @import("create_project.zig");
const create_segment = @import("create_segment.zig");
const delete_experiment = @import("delete_experiment.zig");
const delete_feature = @import("delete_feature.zig");
const delete_launch = @import("delete_launch.zig");
const delete_project = @import("delete_project.zig");
const delete_segment = @import("delete_segment.zig");
const evaluate_feature = @import("evaluate_feature.zig");
const get_experiment = @import("get_experiment.zig");
const get_experiment_results = @import("get_experiment_results.zig");
const get_feature = @import("get_feature.zig");
const get_launch = @import("get_launch.zig");
const get_project = @import("get_project.zig");
const get_segment = @import("get_segment.zig");
const list_experiments = @import("list_experiments.zig");
const list_features = @import("list_features.zig");
const list_launches = @import("list_launches.zig");
const list_projects = @import("list_projects.zig");
const list_segment_references = @import("list_segment_references.zig");
const list_segments = @import("list_segments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_project_events = @import("put_project_events.zig");
const start_experiment = @import("start_experiment.zig");
const start_launch = @import("start_launch.zig");
const stop_experiment = @import("stop_experiment.zig");
const stop_launch = @import("stop_launch.zig");
const tag_resource = @import("tag_resource.zig");
const test_segment_pattern = @import("test_segment_pattern.zig");
const untag_resource = @import("untag_resource.zig");
const update_experiment = @import("update_experiment.zig");
const update_feature = @import("update_feature.zig");
const update_launch = @import("update_launch.zig");
const update_project = @import("update_project.zig");
const update_project_data_delivery = @import("update_project_data_delivery.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Evidently";

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

    /// This operation assigns feature variation to user sessions. For each user
    /// session, you pass in an `entityID` that represents the user. Evidently then
    /// checks the evaluation rules and assigns the variation.
    ///
    /// The first rules that are evaluated are the override rules. If the user's
    /// `entityID` matches an override rule, the user is served the variation
    /// specified by that rule.
    ///
    /// Next, if there is a launch of the feature, the user might be assigned to a
    /// variation in the launch. The chance of this depends on the percentage of
    /// users that are allocated to that launch. If the user is enrolled in the
    /// launch, the variation they are served depends on the allocation of the
    /// various feature variations used for the launch.
    ///
    /// If the user is not assigned to a launch, and there is an ongoing experiment
    /// for this feature, the user might be assigned to a variation in the
    /// experiment. The chance of this depends on the percentage of users that are
    /// allocated to that experiment. If the user is enrolled in the experiment, the
    /// variation they are served depends on the allocation of the various feature
    /// variations used for the experiment.
    ///
    /// If the user is not assigned to a launch or experiment, they are served the
    /// default variation.
    pub fn batchEvaluateFeature(self: *Self, allocator: std.mem.Allocator, input: batch_evaluate_feature.BatchEvaluateFeatureInput, options: CallOptions) !batch_evaluate_feature.BatchEvaluateFeatureOutput {
        return batch_evaluate_feature.execute(self, allocator, input, options);
    }

    /// Creates an Evidently *experiment*. Before you create an experiment, you must
    /// create the feature to use for the experiment.
    ///
    /// An experiment helps you make feature design decisions based on evidence and
    /// data. An experiment can test as many as five variations at once. Evidently
    /// collects experiment data and analyzes it by statistical methods, and
    /// provides clear recommendations about which variations perform better.
    ///
    /// You can optionally specify a `segment` to have the experiment consider only
    /// certain audience types in the experiment, such as using only user sessions
    /// from a certain location or who use a certain internet browser.
    ///
    /// Don't use this operation to update an existing experiment. Instead, use
    /// [UpdateExperiment](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_UpdateExperiment.html).
    pub fn createExperiment(self: *Self, allocator: std.mem.Allocator, input: create_experiment.CreateExperimentInput, options: CallOptions) !create_experiment.CreateExperimentOutput {
        return create_experiment.execute(self, allocator, input, options);
    }

    /// Creates an Evidently *feature* that you want to launch or test. You can
    /// define up to five variations of a feature, and use these variations in your
    /// launches and experiments. A feature must be created in a project. For
    /// information about creating a project, see
    /// [CreateProject](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_CreateProject.html).
    ///
    /// Don't use this operation to update an existing feature. Instead, use
    /// [UpdateFeature](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_UpdateFeature.html).
    pub fn createFeature(self: *Self, allocator: std.mem.Allocator, input: create_feature.CreateFeatureInput, options: CallOptions) !create_feature.CreateFeatureOutput {
        return create_feature.execute(self, allocator, input, options);
    }

    /// Creates a *launch* of a given feature. Before you create a launch, you must
    /// create the feature to use for the launch.
    ///
    /// You can use a launch to safely validate new features by serving them to a
    /// specified percentage of your users while you roll out the feature. You can
    /// monitor the performance of the new feature to help you decide when to ramp
    /// up traffic to more users. This helps you reduce risk and identify unintended
    /// consequences before you fully launch the feature.
    ///
    /// Don't use this operation to update an existing launch. Instead, use
    /// [UpdateLaunch](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_UpdateLaunch.html).
    pub fn createLaunch(self: *Self, allocator: std.mem.Allocator, input: create_launch.CreateLaunchInput, options: CallOptions) !create_launch.CreateLaunchOutput {
        return create_launch.execute(self, allocator, input, options);
    }

    /// Creates a project, which is the logical object in Evidently that can contain
    /// features, launches, and experiments. Use projects to group similar features
    /// together.
    ///
    /// To update an existing project, use
    /// [UpdateProject](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_UpdateProject.html).
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: CallOptions) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Use this operation to define a *segment* of your audience. A segment is a
    /// portion of your audience that share one or more characteristics. Examples
    /// could be Chrome browser users, users in Europe, or Firefox browser users in
    /// Europe who also fit other criteria that your application collects, such as
    /// age.
    ///
    /// Using a segment in an experiment limits that experiment to evaluate only the
    /// users who match the segment criteria. Using one or more segments in a launch
    /// allows you to define different traffic splits for the different audience
    /// segments.
    ///
    /// For more information about segment pattern syntax, see [ Segment rule
    /// pattern
    /// syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Evidently-segments.html#CloudWatch-Evidently-segments-syntax.html).
    ///
    /// The pattern that you define for a segment is matched against the value of
    /// `evaluationContext`, which is passed into Evidently in the
    /// [EvaluateFeature](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_EvaluateFeature.html) operation, when Evidently assigns a feature variation to a user.
    pub fn createSegment(self: *Self, allocator: std.mem.Allocator, input: create_segment.CreateSegmentInput, options: CallOptions) !create_segment.CreateSegmentOutput {
        return create_segment.execute(self, allocator, input, options);
    }

    /// Deletes an Evidently experiment. The feature used for the experiment is not
    /// deleted.
    ///
    /// To stop an experiment without deleting it, use
    /// [StopExperiment](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_StopExperiment.html).
    pub fn deleteExperiment(self: *Self, allocator: std.mem.Allocator, input: delete_experiment.DeleteExperimentInput, options: CallOptions) !delete_experiment.DeleteExperimentOutput {
        return delete_experiment.execute(self, allocator, input, options);
    }

    /// Deletes an Evidently feature.
    pub fn deleteFeature(self: *Self, allocator: std.mem.Allocator, input: delete_feature.DeleteFeatureInput, options: CallOptions) !delete_feature.DeleteFeatureOutput {
        return delete_feature.execute(self, allocator, input, options);
    }

    /// Deletes an Evidently launch. The feature used for the launch is not deleted.
    ///
    /// To stop a launch without deleting it, use
    /// [StopLaunch](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_StopLaunch.html).
    pub fn deleteLaunch(self: *Self, allocator: std.mem.Allocator, input: delete_launch.DeleteLaunchInput, options: CallOptions) !delete_launch.DeleteLaunchOutput {
        return delete_launch.execute(self, allocator, input, options);
    }

    /// Deletes an Evidently project. Before you can delete a project, you must
    /// delete all the features that the project contains. To delete a feature, use
    /// [DeleteFeature](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_DeleteFeature.html).
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: CallOptions) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes a segment. You can't delete a segment that is being used in a launch
    /// or experiment, even if that launch or experiment is not currently running.
    pub fn deleteSegment(self: *Self, allocator: std.mem.Allocator, input: delete_segment.DeleteSegmentInput, options: CallOptions) !delete_segment.DeleteSegmentOutput {
        return delete_segment.execute(self, allocator, input, options);
    }

    /// This operation assigns a feature variation to one given user session. You
    /// pass in an `entityID` that represents the user. Evidently then checks the
    /// evaluation rules and assigns the variation.
    ///
    /// The first rules that are evaluated are the override rules. If the user's
    /// `entityID` matches an override rule, the user is served the variation
    /// specified by that rule.
    ///
    /// If there is a current launch with this feature that uses segment overrides,
    /// and if the user session's `evaluationContext` matches a segment rule defined
    /// in a segment override, the configuration in the segment overrides is used.
    /// For more information about segments, see
    /// [CreateSegment](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_CreateSegment.html) and [Use segments to focus your audience](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Evidently-segments.html).
    ///
    /// If there is a launch with no segment overrides, the user might be assigned
    /// to a variation in the launch. The chance of this depends on the percentage
    /// of users that are allocated to that launch. If the user is enrolled in the
    /// launch, the variation they are served depends on the allocation of the
    /// various feature variations used for the launch.
    ///
    /// If the user is not assigned to a launch, and there is an ongoing experiment
    /// for this feature, the user might be assigned to a variation in the
    /// experiment. The chance of this depends on the percentage of users that are
    /// allocated to that experiment.
    ///
    /// If the experiment uses a segment, then only user sessions with
    /// `evaluationContext` values that match the segment rule are used in the
    /// experiment.
    ///
    /// If the user is enrolled in the experiment, the variation they are served
    /// depends on the allocation of the various feature variations used for the
    /// experiment.
    ///
    /// If the user is not assigned to a launch or experiment, they are served the
    /// default variation.
    pub fn evaluateFeature(self: *Self, allocator: std.mem.Allocator, input: evaluate_feature.EvaluateFeatureInput, options: CallOptions) !evaluate_feature.EvaluateFeatureOutput {
        return evaluate_feature.execute(self, allocator, input, options);
    }

    /// Returns the details about one experiment. You must already know the
    /// experiment name. To retrieve a list of experiments in your account, use
    /// [ListExperiments](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_ListExperiments.html).
    pub fn getExperiment(self: *Self, allocator: std.mem.Allocator, input: get_experiment.GetExperimentInput, options: CallOptions) !get_experiment.GetExperimentOutput {
        return get_experiment.execute(self, allocator, input, options);
    }

    /// Retrieves the results of a running or completed experiment. No results are
    /// available until there have been 100 events for each variation and at least
    /// 10 minutes have passed since the start of the experiment. To increase the
    /// statistical power, Evidently performs an additional offline p-value analysis
    /// at the end of the experiment. Offline p-value analysis can detect
    /// statistical significance in some cases where the anytime p-values used
    /// during the experiment do not find statistical significance.
    ///
    /// Experiment results are available up to 63 days after the start of the
    /// experiment. They are not available after that because of CloudWatch data
    /// retention policies.
    pub fn getExperimentResults(self: *Self, allocator: std.mem.Allocator, input: get_experiment_results.GetExperimentResultsInput, options: CallOptions) !get_experiment_results.GetExperimentResultsOutput {
        return get_experiment_results.execute(self, allocator, input, options);
    }

    /// Returns the details about one feature. You must already know the feature
    /// name. To retrieve a list of features in your account, use
    /// [ListFeatures](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_ListFeatures.html).
    pub fn getFeature(self: *Self, allocator: std.mem.Allocator, input: get_feature.GetFeatureInput, options: CallOptions) !get_feature.GetFeatureOutput {
        return get_feature.execute(self, allocator, input, options);
    }

    /// Returns the details about one launch. You must already know the launch name.
    /// To retrieve a list of launches in your account, use
    /// [ListLaunches](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_ListLaunches.html).
    pub fn getLaunch(self: *Self, allocator: std.mem.Allocator, input: get_launch.GetLaunchInput, options: CallOptions) !get_launch.GetLaunchOutput {
        return get_launch.execute(self, allocator, input, options);
    }

    /// Returns the details about one launch. You must already know the project
    /// name. To retrieve a list of projects in your account, use
    /// [ListProjects](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_ListProjects.html).
    pub fn getProject(self: *Self, allocator: std.mem.Allocator, input: get_project.GetProjectInput, options: CallOptions) !get_project.GetProjectOutput {
        return get_project.execute(self, allocator, input, options);
    }

    /// Returns information about the specified segment. Specify the segment you
    /// want to view by specifying its ARN.
    pub fn getSegment(self: *Self, allocator: std.mem.Allocator, input: get_segment.GetSegmentInput, options: CallOptions) !get_segment.GetSegmentOutput {
        return get_segment.execute(self, allocator, input, options);
    }

    /// Returns configuration details about all the experiments in the specified
    /// project.
    pub fn listExperiments(self: *Self, allocator: std.mem.Allocator, input: list_experiments.ListExperimentsInput, options: CallOptions) !list_experiments.ListExperimentsOutput {
        return list_experiments.execute(self, allocator, input, options);
    }

    /// Returns configuration details about all the features in the specified
    /// project.
    pub fn listFeatures(self: *Self, allocator: std.mem.Allocator, input: list_features.ListFeaturesInput, options: CallOptions) !list_features.ListFeaturesOutput {
        return list_features.execute(self, allocator, input, options);
    }

    /// Returns configuration details about all the launches in the specified
    /// project.
    pub fn listLaunches(self: *Self, allocator: std.mem.Allocator, input: list_launches.ListLaunchesInput, options: CallOptions) !list_launches.ListLaunchesOutput {
        return list_launches.execute(self, allocator, input, options);
    }

    /// Returns configuration details about all the projects in the current Region
    /// in your account.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: CallOptions) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Use this operation to find which experiments or launches are using a
    /// specified segment.
    pub fn listSegmentReferences(self: *Self, allocator: std.mem.Allocator, input: list_segment_references.ListSegmentReferencesInput, options: CallOptions) !list_segment_references.ListSegmentReferencesOutput {
        return list_segment_references.execute(self, allocator, input, options);
    }

    /// Returns a list of audience segments that you have created in your account in
    /// this Region.
    pub fn listSegments(self: *Self, allocator: std.mem.Allocator, input: list_segments.ListSegmentsInput, options: CallOptions) !list_segments.ListSegmentsOutput {
        return list_segments.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with an Evidently resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sends performance events to Evidently. These events can be used to evaluate
    /// a launch or an experiment.
    pub fn putProjectEvents(self: *Self, allocator: std.mem.Allocator, input: put_project_events.PutProjectEventsInput, options: CallOptions) !put_project_events.PutProjectEventsOutput {
        return put_project_events.execute(self, allocator, input, options);
    }

    /// Starts an existing experiment. To create an experiment, use
    /// [CreateExperiment](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_CreateExperiment.html).
    pub fn startExperiment(self: *Self, allocator: std.mem.Allocator, input: start_experiment.StartExperimentInput, options: CallOptions) !start_experiment.StartExperimentOutput {
        return start_experiment.execute(self, allocator, input, options);
    }

    /// Starts an existing launch. To create a launch, use
    /// [CreateLaunch](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_CreateLaunch.html).
    pub fn startLaunch(self: *Self, allocator: std.mem.Allocator, input: start_launch.StartLaunchInput, options: CallOptions) !start_launch.StartLaunchOutput {
        return start_launch.execute(self, allocator, input, options);
    }

    /// Stops an experiment that is currently running. If you stop an experiment,
    /// you can't resume it or restart it.
    pub fn stopExperiment(self: *Self, allocator: std.mem.Allocator, input: stop_experiment.StopExperimentInput, options: CallOptions) !stop_experiment.StopExperimentOutput {
        return stop_experiment.execute(self, allocator, input, options);
    }

    /// Stops a launch that is currently running. After you stop a launch, you will
    /// not be able to resume it or restart it. Also, it will not be evaluated as a
    /// rule for traffic allocation, and the traffic that was allocated to the
    /// launch will instead be available to the feature's experiment, if there is
    /// one. Otherwise, all traffic will be served the default variation after the
    /// launch is stopped.
    pub fn stopLaunch(self: *Self, allocator: std.mem.Allocator, input: stop_launch.StopLaunchInput, options: CallOptions) !stop_launch.StopLaunchOutput {
        return stop_launch.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified CloudWatch
    /// Evidently resource. Projects, features, launches, and experiments can be
    /// tagged.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can use the `TagResource` action with a resource that already has tags.
    /// If you specify a new tag key for the resource, this tag is appended to the
    /// list of tags associated with the alarm. If you specify a tag key that is
    /// already associated with the resource, the new tag value that you specify
    /// replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource.
    ///
    /// For more information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Use this operation to test a rules pattern that you plan to use to create an
    /// audience segment. For more information about segments, see
    /// [CreateSegment](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_CreateSegment.html).
    pub fn testSegmentPattern(self: *Self, allocator: std.mem.Allocator, input: test_segment_pattern.TestSegmentPatternInput, options: CallOptions) !test_segment_pattern.TestSegmentPatternOutput {
        return test_segment_pattern.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Evidently experiment.
    ///
    /// Don't use this operation to update an experiment's tag. Instead, use
    /// [TagResource](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_TagResource.html).
    pub fn updateExperiment(self: *Self, allocator: std.mem.Allocator, input: update_experiment.UpdateExperimentInput, options: CallOptions) !update_experiment.UpdateExperimentOutput {
        return update_experiment.execute(self, allocator, input, options);
    }

    /// Updates an existing feature.
    ///
    /// You can't use this operation to update the tags of an existing feature.
    /// Instead, use
    /// [TagResource](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_TagResource.html).
    pub fn updateFeature(self: *Self, allocator: std.mem.Allocator, input: update_feature.UpdateFeatureInput, options: CallOptions) !update_feature.UpdateFeatureOutput {
        return update_feature.execute(self, allocator, input, options);
    }

    /// Updates a launch of a given feature.
    ///
    /// Don't use this operation to update the tags of an existing launch. Instead,
    /// use
    /// [TagResource](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_TagResource.html).
    pub fn updateLaunch(self: *Self, allocator: std.mem.Allocator, input: update_launch.UpdateLaunchInput, options: CallOptions) !update_launch.UpdateLaunchOutput {
        return update_launch.execute(self, allocator, input, options);
    }

    /// Updates the description of an existing project.
    ///
    /// To create a new project, use
    /// [CreateProject](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_CreateProject.html).
    ///
    /// Don't use this operation to update the data storage options of a project.
    /// Instead, use
    /// [UpdateProjectDataDelivery](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_UpdateProjectDataDelivery.html).
    ///
    /// Don't use this operation to update the tags of a project. Instead, use
    /// [TagResource](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_TagResource.html).
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: CallOptions) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Updates the data storage options for this project. If you store evaluation
    /// events, you an keep them and analyze them on your own. If you choose not to
    /// store evaluation events, Evidently deletes them after using them to produce
    /// metrics and other experiment results that you can view.
    ///
    /// You can't specify both `cloudWatchLogs` and `s3Destination` in the same
    /// operation.
    pub fn updateProjectDataDelivery(self: *Self, allocator: std.mem.Allocator, input: update_project_data_delivery.UpdateProjectDataDeliveryInput, options: CallOptions) !update_project_data_delivery.UpdateProjectDataDeliveryOutput {
        return update_project_data_delivery.execute(self, allocator, input, options);
    }

    pub fn listExperimentsPaginator(self: *Self, params: list_experiments.ListExperimentsInput) paginator.ListExperimentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFeaturesPaginator(self: *Self, params: list_features.ListFeaturesInput) paginator.ListFeaturesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLaunchesPaginator(self: *Self, params: list_launches.ListLaunchesInput) paginator.ListLaunchesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSegmentReferencesPaginator(self: *Self, params: list_segment_references.ListSegmentReferencesInput) paginator.ListSegmentReferencesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSegmentsPaginator(self: *Self, params: list_segments.ListSegmentsInput) paginator.ListSegmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
