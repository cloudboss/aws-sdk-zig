const aws = @import("aws");
const std = @import("std");

const batch_delete_recipe_version = @import("batch_delete_recipe_version.zig");
const create_dataset = @import("create_dataset.zig");
const create_profile_job = @import("create_profile_job.zig");
const create_project = @import("create_project.zig");
const create_recipe = @import("create_recipe.zig");
const create_recipe_job = @import("create_recipe_job.zig");
const create_ruleset = @import("create_ruleset.zig");
const create_schedule = @import("create_schedule.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_job = @import("delete_job.zig");
const delete_project = @import("delete_project.zig");
const delete_recipe_version = @import("delete_recipe_version.zig");
const delete_ruleset = @import("delete_ruleset.zig");
const delete_schedule = @import("delete_schedule.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_job = @import("describe_job.zig");
const describe_job_run = @import("describe_job_run.zig");
const describe_project = @import("describe_project.zig");
const describe_recipe = @import("describe_recipe.zig");
const describe_ruleset = @import("describe_ruleset.zig");
const describe_schedule = @import("describe_schedule.zig");
const list_datasets = @import("list_datasets.zig");
const list_job_runs = @import("list_job_runs.zig");
const list_jobs = @import("list_jobs.zig");
const list_projects = @import("list_projects.zig");
const list_recipe_versions = @import("list_recipe_versions.zig");
const list_recipes = @import("list_recipes.zig");
const list_rulesets = @import("list_rulesets.zig");
const list_schedules = @import("list_schedules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const publish_recipe = @import("publish_recipe.zig");
const send_project_session_action = @import("send_project_session_action.zig");
const start_job_run = @import("start_job_run.zig");
const start_project_session = @import("start_project_session.zig");
const stop_job_run = @import("stop_job_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_dataset = @import("update_dataset.zig");
const update_profile_job = @import("update_profile_job.zig");
const update_project = @import("update_project.zig");
const update_recipe = @import("update_recipe.zig");
const update_recipe_job = @import("update_recipe_job.zig");
const update_ruleset = @import("update_ruleset.zig");
const update_schedule = @import("update_schedule.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DataBrew";

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

    /// Deletes one or more versions of a recipe at a time.
    ///
    /// The entire request will be rejected if:
    ///
    /// * The recipe does not exist.
    ///
    /// * There is an invalid version identifier in the list of versions.
    ///
    /// * The version list is empty.
    ///
    /// * The version list size exceeds 50.
    ///
    /// * The version list contains duplicate entries.
    ///
    /// The request will complete successfully, but with partial failures, if:
    ///
    /// * A version does not exist.
    ///
    /// * A version is being used by a job.
    ///
    /// * You specify `LATEST_WORKING`, but it's being used by a
    /// project.
    ///
    /// * The version fails to be deleted.
    ///
    /// The `LATEST_WORKING` version will only be deleted if the recipe has no
    /// other versions. If you try to delete `LATEST_WORKING` while other versions
    /// exist (or if they can't be deleted), then `LATEST_WORKING` will be listed as
    /// partial failure in the response.
    pub fn batchDeleteRecipeVersion(self: *Self, allocator: std.mem.Allocator, input: batch_delete_recipe_version.BatchDeleteRecipeVersionInput, options: batch_delete_recipe_version.Options) !batch_delete_recipe_version.BatchDeleteRecipeVersionOutput {
        return batch_delete_recipe_version.execute(self, allocator, input, options);
    }

    /// Creates a new DataBrew dataset.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: create_dataset.Options) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates a new job to analyze a dataset and create its data profile.
    pub fn createProfileJob(self: *Self, allocator: std.mem.Allocator, input: create_profile_job.CreateProfileJobInput, options: create_profile_job.Options) !create_profile_job.CreateProfileJobOutput {
        return create_profile_job.execute(self, allocator, input, options);
    }

    /// Creates a new DataBrew project.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: create_project.Options) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Creates a new DataBrew recipe.
    pub fn createRecipe(self: *Self, allocator: std.mem.Allocator, input: create_recipe.CreateRecipeInput, options: create_recipe.Options) !create_recipe.CreateRecipeOutput {
        return create_recipe.execute(self, allocator, input, options);
    }

    /// Creates a new job to transform input data, using steps defined in an
    /// existing Glue DataBrew recipe
    pub fn createRecipeJob(self: *Self, allocator: std.mem.Allocator, input: create_recipe_job.CreateRecipeJobInput, options: create_recipe_job.Options) !create_recipe_job.CreateRecipeJobOutput {
        return create_recipe_job.execute(self, allocator, input, options);
    }

    /// Creates a new ruleset that can be used in a profile job to validate
    /// the data quality of a dataset.
    pub fn createRuleset(self: *Self, allocator: std.mem.Allocator, input: create_ruleset.CreateRulesetInput, options: create_ruleset.Options) !create_ruleset.CreateRulesetOutput {
        return create_ruleset.execute(self, allocator, input, options);
    }

    /// Creates a new schedule for one or more DataBrew jobs. Jobs can be run at a
    /// specific
    /// date and time, or at regular intervals.
    pub fn createSchedule(self: *Self, allocator: std.mem.Allocator, input: create_schedule.CreateScheduleInput, options: create_schedule.Options) !create_schedule.CreateScheduleOutput {
        return create_schedule.execute(self, allocator, input, options);
    }

    /// Deletes a dataset from DataBrew.
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: delete_dataset.Options) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes the specified DataBrew job.
    pub fn deleteJob(self: *Self, allocator: std.mem.Allocator, input: delete_job.DeleteJobInput, options: delete_job.Options) !delete_job.DeleteJobOutput {
        return delete_job.execute(self, allocator, input, options);
    }

    /// Deletes an existing DataBrew project.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: delete_project.Options) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes a single version of a DataBrew recipe.
    pub fn deleteRecipeVersion(self: *Self, allocator: std.mem.Allocator, input: delete_recipe_version.DeleteRecipeVersionInput, options: delete_recipe_version.Options) !delete_recipe_version.DeleteRecipeVersionOutput {
        return delete_recipe_version.execute(self, allocator, input, options);
    }

    /// Deletes a ruleset.
    pub fn deleteRuleset(self: *Self, allocator: std.mem.Allocator, input: delete_ruleset.DeleteRulesetInput, options: delete_ruleset.Options) !delete_ruleset.DeleteRulesetOutput {
        return delete_ruleset.execute(self, allocator, input, options);
    }

    /// Deletes the specified DataBrew schedule.
    pub fn deleteSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_schedule.DeleteScheduleInput, options: delete_schedule.Options) !delete_schedule.DeleteScheduleOutput {
        return delete_schedule.execute(self, allocator, input, options);
    }

    /// Returns the definition of a specific DataBrew dataset.
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: describe_dataset.Options) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Returns the definition of a specific DataBrew job.
    pub fn describeJob(self: *Self, allocator: std.mem.Allocator, input: describe_job.DescribeJobInput, options: describe_job.Options) !describe_job.DescribeJobOutput {
        return describe_job.execute(self, allocator, input, options);
    }

    /// Represents one run of a DataBrew job.
    pub fn describeJobRun(self: *Self, allocator: std.mem.Allocator, input: describe_job_run.DescribeJobRunInput, options: describe_job_run.Options) !describe_job_run.DescribeJobRunOutput {
        return describe_job_run.execute(self, allocator, input, options);
    }

    /// Returns the definition of a specific DataBrew project.
    pub fn describeProject(self: *Self, allocator: std.mem.Allocator, input: describe_project.DescribeProjectInput, options: describe_project.Options) !describe_project.DescribeProjectOutput {
        return describe_project.execute(self, allocator, input, options);
    }

    /// Returns the definition of a specific DataBrew recipe corresponding to a
    /// particular
    /// version.
    pub fn describeRecipe(self: *Self, allocator: std.mem.Allocator, input: describe_recipe.DescribeRecipeInput, options: describe_recipe.Options) !describe_recipe.DescribeRecipeOutput {
        return describe_recipe.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about the ruleset.
    pub fn describeRuleset(self: *Self, allocator: std.mem.Allocator, input: describe_ruleset.DescribeRulesetInput, options: describe_ruleset.Options) !describe_ruleset.DescribeRulesetOutput {
        return describe_ruleset.execute(self, allocator, input, options);
    }

    /// Returns the definition of a specific DataBrew schedule.
    pub fn describeSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_schedule.DescribeScheduleInput, options: describe_schedule.Options) !describe_schedule.DescribeScheduleOutput {
        return describe_schedule.execute(self, allocator, input, options);
    }

    /// Lists all of the DataBrew datasets.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: list_datasets.Options) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Lists all of the previous runs of a particular DataBrew job.
    pub fn listJobRuns(self: *Self, allocator: std.mem.Allocator, input: list_job_runs.ListJobRunsInput, options: list_job_runs.Options) !list_job_runs.ListJobRunsOutput {
        return list_job_runs.execute(self, allocator, input, options);
    }

    /// Lists all of the DataBrew jobs that are defined.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Lists all of the DataBrew projects that are defined.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: list_projects.Options) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Lists the versions of a particular DataBrew recipe, except for
    /// `LATEST_WORKING`.
    pub fn listRecipeVersions(self: *Self, allocator: std.mem.Allocator, input: list_recipe_versions.ListRecipeVersionsInput, options: list_recipe_versions.Options) !list_recipe_versions.ListRecipeVersionsOutput {
        return list_recipe_versions.execute(self, allocator, input, options);
    }

    /// Lists all of the DataBrew recipes that are defined.
    pub fn listRecipes(self: *Self, allocator: std.mem.Allocator, input: list_recipes.ListRecipesInput, options: list_recipes.Options) !list_recipes.ListRecipesOutput {
        return list_recipes.execute(self, allocator, input, options);
    }

    /// List all rulesets available in the current account or rulesets associated
    /// with a specific resource (dataset).
    pub fn listRulesets(self: *Self, allocator: std.mem.Allocator, input: list_rulesets.ListRulesetsInput, options: list_rulesets.Options) !list_rulesets.ListRulesetsOutput {
        return list_rulesets.execute(self, allocator, input, options);
    }

    /// Lists the DataBrew schedules that are defined.
    pub fn listSchedules(self: *Self, allocator: std.mem.Allocator, input: list_schedules.ListSchedulesInput, options: list_schedules.Options) !list_schedules.ListSchedulesOutput {
        return list_schedules.execute(self, allocator, input, options);
    }

    /// Lists all the tags for a DataBrew resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Publishes a new version of a DataBrew recipe.
    pub fn publishRecipe(self: *Self, allocator: std.mem.Allocator, input: publish_recipe.PublishRecipeInput, options: publish_recipe.Options) !publish_recipe.PublishRecipeOutput {
        return publish_recipe.execute(self, allocator, input, options);
    }

    /// Performs a recipe step within an interactive DataBrew session that's
    /// currently
    /// open.
    pub fn sendProjectSessionAction(self: *Self, allocator: std.mem.Allocator, input: send_project_session_action.SendProjectSessionActionInput, options: send_project_session_action.Options) !send_project_session_action.SendProjectSessionActionOutput {
        return send_project_session_action.execute(self, allocator, input, options);
    }

    /// Runs a DataBrew job.
    pub fn startJobRun(self: *Self, allocator: std.mem.Allocator, input: start_job_run.StartJobRunInput, options: start_job_run.Options) !start_job_run.StartJobRunOutput {
        return start_job_run.execute(self, allocator, input, options);
    }

    /// Creates an interactive session, enabling you to manipulate data in a
    /// DataBrew
    /// project.
    pub fn startProjectSession(self: *Self, allocator: std.mem.Allocator, input: start_project_session.StartProjectSessionInput, options: start_project_session.Options) !start_project_session.StartProjectSessionOutput {
        return start_project_session.execute(self, allocator, input, options);
    }

    /// Stops a particular run of a job.
    pub fn stopJobRun(self: *Self, allocator: std.mem.Allocator, input: stop_job_run.StopJobRunInput, options: stop_job_run.Options) !stop_job_run.StopJobRunOutput {
        return stop_job_run.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to a DataBrew resource, such as a dataset, project,
    /// recipe, job, or
    /// schedule.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from a DataBrew resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies the definition of an existing DataBrew dataset.
    pub fn updateDataset(self: *Self, allocator: std.mem.Allocator, input: update_dataset.UpdateDatasetInput, options: update_dataset.Options) !update_dataset.UpdateDatasetOutput {
        return update_dataset.execute(self, allocator, input, options);
    }

    /// Modifies the definition of an existing profile job.
    pub fn updateProfileJob(self: *Self, allocator: std.mem.Allocator, input: update_profile_job.UpdateProfileJobInput, options: update_profile_job.Options) !update_profile_job.UpdateProfileJobOutput {
        return update_profile_job.execute(self, allocator, input, options);
    }

    /// Modifies the definition of an existing DataBrew project.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: update_project.Options) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Modifies the definition of the `LATEST_WORKING` version of a DataBrew
    /// recipe.
    pub fn updateRecipe(self: *Self, allocator: std.mem.Allocator, input: update_recipe.UpdateRecipeInput, options: update_recipe.Options) !update_recipe.UpdateRecipeOutput {
        return update_recipe.execute(self, allocator, input, options);
    }

    /// Modifies the definition of an existing DataBrew recipe job.
    pub fn updateRecipeJob(self: *Self, allocator: std.mem.Allocator, input: update_recipe_job.UpdateRecipeJobInput, options: update_recipe_job.Options) !update_recipe_job.UpdateRecipeJobOutput {
        return update_recipe_job.execute(self, allocator, input, options);
    }

    /// Updates specified ruleset.
    pub fn updateRuleset(self: *Self, allocator: std.mem.Allocator, input: update_ruleset.UpdateRulesetInput, options: update_ruleset.Options) !update_ruleset.UpdateRulesetOutput {
        return update_ruleset.execute(self, allocator, input, options);
    }

    /// Modifies the definition of an existing DataBrew schedule.
    pub fn updateSchedule(self: *Self, allocator: std.mem.Allocator, input: update_schedule.UpdateScheduleInput, options: update_schedule.Options) !update_schedule.UpdateScheduleOutput {
        return update_schedule.execute(self, allocator, input, options);
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobRunsPaginator(self: *Self, params: list_job_runs.ListJobRunsInput) paginator.ListJobRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecipeVersionsPaginator(self: *Self, params: list_recipe_versions.ListRecipeVersionsInput) paginator.ListRecipeVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecipesPaginator(self: *Self, params: list_recipes.ListRecipesInput) paginator.ListRecipesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRulesetsPaginator(self: *Self, params: list_rulesets.ListRulesetsInput) paginator.ListRulesetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchedulesPaginator(self: *Self, params: list_schedules.ListSchedulesInput) paginator.ListSchedulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
