const aws = @import("aws");
const std = @import("std");

const create_experiment_template = @import("create_experiment_template.zig");
const create_target_account_configuration = @import("create_target_account_configuration.zig");
const delete_experiment_template = @import("delete_experiment_template.zig");
const delete_target_account_configuration = @import("delete_target_account_configuration.zig");
const get_action = @import("get_action.zig");
const get_experiment = @import("get_experiment.zig");
const get_experiment_target_account_configuration = @import("get_experiment_target_account_configuration.zig");
const get_experiment_template = @import("get_experiment_template.zig");
const get_safety_lever = @import("get_safety_lever.zig");
const get_target_account_configuration = @import("get_target_account_configuration.zig");
const get_target_resource_type = @import("get_target_resource_type.zig");
const list_actions = @import("list_actions.zig");
const list_experiment_resolved_targets = @import("list_experiment_resolved_targets.zig");
const list_experiment_target_account_configurations = @import("list_experiment_target_account_configurations.zig");
const list_experiment_templates = @import("list_experiment_templates.zig");
const list_experiments = @import("list_experiments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_target_account_configurations = @import("list_target_account_configurations.zig");
const list_target_resource_types = @import("list_target_resource_types.zig");
const start_experiment = @import("start_experiment.zig");
const stop_experiment = @import("stop_experiment.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_experiment_template = @import("update_experiment_template.zig");
const update_safety_lever_state = @import("update_safety_lever_state.zig");
const update_target_account_configuration = @import("update_target_account_configuration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "fis";

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

    /// Creates an experiment template.
    ///
    /// An experiment template includes the following components:
    ///
    /// * **Targets**: A target can be a specific resource in
    /// your Amazon Web Services environment, or one or more resources that match
    /// criteria that you
    /// specify, for example, resources that have specific tags.
    ///
    /// * **Actions**: The actions to carry out on the
    /// target. You can specify multiple actions, the duration of each action, and
    /// when to start each action during an experiment.
    ///
    /// * **Stop conditions**: If a stop condition is
    /// triggered while an experiment is running, the experiment is automatically
    /// stopped. You can define a stop condition as a CloudWatch alarm.
    ///
    /// For more information, see [experiment
    /// templates](https://docs.aws.amazon.com/fis/latest/userguide/experiment-templates.html)
    /// in the *Fault Injection Service User Guide*.
    pub fn createExperimentTemplate(self: *Self, allocator: std.mem.Allocator, input: create_experiment_template.CreateExperimentTemplateInput, options: CallOptions) !create_experiment_template.CreateExperimentTemplateOutput {
        return create_experiment_template.execute(self, allocator, input, options);
    }

    /// Creates a target account configuration for the experiment template. A target
    /// account configuration
    /// is required when `accountTargeting` of `experimentOptions` is set to
    /// `multi-account`.
    /// For more information, see [experiment
    /// options](https://docs.aws.amazon.com/fis/latest/userguide/experiment-options.html)
    /// in the *Fault Injection Service User Guide*.
    pub fn createTargetAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_target_account_configuration.CreateTargetAccountConfigurationInput, options: CallOptions) !create_target_account_configuration.CreateTargetAccountConfigurationOutput {
        return create_target_account_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified experiment template.
    pub fn deleteExperimentTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_experiment_template.DeleteExperimentTemplateInput, options: CallOptions) !delete_experiment_template.DeleteExperimentTemplateOutput {
        return delete_experiment_template.execute(self, allocator, input, options);
    }

    /// Deletes the specified target account configuration of the experiment
    /// template.
    pub fn deleteTargetAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_target_account_configuration.DeleteTargetAccountConfigurationInput, options: CallOptions) !delete_target_account_configuration.DeleteTargetAccountConfigurationOutput {
        return delete_target_account_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified FIS action.
    pub fn getAction(self: *Self, allocator: std.mem.Allocator, input: get_action.GetActionInput, options: CallOptions) !get_action.GetActionOutput {
        return get_action.execute(self, allocator, input, options);
    }

    /// Gets information about the specified experiment.
    pub fn getExperiment(self: *Self, allocator: std.mem.Allocator, input: get_experiment.GetExperimentInput, options: CallOptions) !get_experiment.GetExperimentOutput {
        return get_experiment.execute(self, allocator, input, options);
    }

    /// Gets information about the specified target account configuration of the
    /// experiment.
    pub fn getExperimentTargetAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_experiment_target_account_configuration.GetExperimentTargetAccountConfigurationInput, options: CallOptions) !get_experiment_target_account_configuration.GetExperimentTargetAccountConfigurationOutput {
        return get_experiment_target_account_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified experiment template.
    pub fn getExperimentTemplate(self: *Self, allocator: std.mem.Allocator, input: get_experiment_template.GetExperimentTemplateInput, options: CallOptions) !get_experiment_template.GetExperimentTemplateOutput {
        return get_experiment_template.execute(self, allocator, input, options);
    }

    /// Gets information about the specified safety lever.
    pub fn getSafetyLever(self: *Self, allocator: std.mem.Allocator, input: get_safety_lever.GetSafetyLeverInput, options: CallOptions) !get_safety_lever.GetSafetyLeverOutput {
        return get_safety_lever.execute(self, allocator, input, options);
    }

    /// Gets information about the specified target account configuration of the
    /// experiment template.
    pub fn getTargetAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_target_account_configuration.GetTargetAccountConfigurationInput, options: CallOptions) !get_target_account_configuration.GetTargetAccountConfigurationOutput {
        return get_target_account_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified resource type.
    pub fn getTargetResourceType(self: *Self, allocator: std.mem.Allocator, input: get_target_resource_type.GetTargetResourceTypeInput, options: CallOptions) !get_target_resource_type.GetTargetResourceTypeOutput {
        return get_target_resource_type.execute(self, allocator, input, options);
    }

    /// Lists the available FIS actions.
    pub fn listActions(self: *Self, allocator: std.mem.Allocator, input: list_actions.ListActionsInput, options: CallOptions) !list_actions.ListActionsOutput {
        return list_actions.execute(self, allocator, input, options);
    }

    /// Lists the resolved targets information of the specified experiment.
    pub fn listExperimentResolvedTargets(self: *Self, allocator: std.mem.Allocator, input: list_experiment_resolved_targets.ListExperimentResolvedTargetsInput, options: CallOptions) !list_experiment_resolved_targets.ListExperimentResolvedTargetsOutput {
        return list_experiment_resolved_targets.execute(self, allocator, input, options);
    }

    /// Lists the target account configurations of the specified experiment.
    pub fn listExperimentTargetAccountConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_experiment_target_account_configurations.ListExperimentTargetAccountConfigurationsInput, options: CallOptions) !list_experiment_target_account_configurations.ListExperimentTargetAccountConfigurationsOutput {
        return list_experiment_target_account_configurations.execute(self, allocator, input, options);
    }

    /// Lists your experiment templates.
    pub fn listExperimentTemplates(self: *Self, allocator: std.mem.Allocator, input: list_experiment_templates.ListExperimentTemplatesInput, options: CallOptions) !list_experiment_templates.ListExperimentTemplatesOutput {
        return list_experiment_templates.execute(self, allocator, input, options);
    }

    /// Lists your experiments.
    pub fn listExperiments(self: *Self, allocator: std.mem.Allocator, input: list_experiments.ListExperimentsInput, options: CallOptions) !list_experiments.ListExperimentsOutput {
        return list_experiments.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the target account configurations of the specified experiment
    /// template.
    pub fn listTargetAccountConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_target_account_configurations.ListTargetAccountConfigurationsInput, options: CallOptions) !list_target_account_configurations.ListTargetAccountConfigurationsOutput {
        return list_target_account_configurations.execute(self, allocator, input, options);
    }

    /// Lists the target resource types.
    pub fn listTargetResourceTypes(self: *Self, allocator: std.mem.Allocator, input: list_target_resource_types.ListTargetResourceTypesInput, options: CallOptions) !list_target_resource_types.ListTargetResourceTypesOutput {
        return list_target_resource_types.execute(self, allocator, input, options);
    }

    /// Starts running an experiment from the specified experiment template.
    pub fn startExperiment(self: *Self, allocator: std.mem.Allocator, input: start_experiment.StartExperimentInput, options: CallOptions) !start_experiment.StartExperimentOutput {
        return start_experiment.execute(self, allocator, input, options);
    }

    /// Stops the specified experiment.
    pub fn stopExperiment(self: *Self, allocator: std.mem.Allocator, input: stop_experiment.StopExperimentInput, options: CallOptions) !stop_experiment.StopExperimentOutput {
        return stop_experiment.execute(self, allocator, input, options);
    }

    /// Applies the specified tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified experiment template.
    pub fn updateExperimentTemplate(self: *Self, allocator: std.mem.Allocator, input: update_experiment_template.UpdateExperimentTemplateInput, options: CallOptions) !update_experiment_template.UpdateExperimentTemplateOutput {
        return update_experiment_template.execute(self, allocator, input, options);
    }

    /// Updates the specified safety lever state.
    pub fn updateSafetyLeverState(self: *Self, allocator: std.mem.Allocator, input: update_safety_lever_state.UpdateSafetyLeverStateInput, options: CallOptions) !update_safety_lever_state.UpdateSafetyLeverStateOutput {
        return update_safety_lever_state.execute(self, allocator, input, options);
    }

    /// Updates the target account configuration for the specified experiment
    /// template.
    pub fn updateTargetAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_target_account_configuration.UpdateTargetAccountConfigurationInput, options: CallOptions) !update_target_account_configuration.UpdateTargetAccountConfigurationOutput {
        return update_target_account_configuration.execute(self, allocator, input, options);
    }

    pub fn listActionsPaginator(self: *Self, params: list_actions.ListActionsInput) paginator.ListActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExperimentResolvedTargetsPaginator(self: *Self, params: list_experiment_resolved_targets.ListExperimentResolvedTargetsInput) paginator.ListExperimentResolvedTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExperimentTemplatesPaginator(self: *Self, params: list_experiment_templates.ListExperimentTemplatesInput) paginator.ListExperimentTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExperimentsPaginator(self: *Self, params: list_experiments.ListExperimentsInput) paginator.ListExperimentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetAccountConfigurationsPaginator(self: *Self, params: list_target_account_configurations.ListTargetAccountConfigurationsInput) paginator.ListTargetAccountConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetResourceTypesPaginator(self: *Self, params: list_target_resource_types.ListTargetResourceTypesInput) paginator.ListTargetResourceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
