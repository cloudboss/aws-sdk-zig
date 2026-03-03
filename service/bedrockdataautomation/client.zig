const aws = @import("aws");
const std = @import("std");

const copy_blueprint_stage = @import("copy_blueprint_stage.zig");
const create_blueprint = @import("create_blueprint.zig");
const create_blueprint_version = @import("create_blueprint_version.zig");
const create_data_automation_project = @import("create_data_automation_project.zig");
const delete_blueprint = @import("delete_blueprint.zig");
const delete_data_automation_project = @import("delete_data_automation_project.zig");
const get_blueprint = @import("get_blueprint.zig");
const get_blueprint_optimization_status = @import("get_blueprint_optimization_status.zig");
const get_data_automation_project = @import("get_data_automation_project.zig");
const invoke_blueprint_optimization_async = @import("invoke_blueprint_optimization_async.zig");
const list_blueprints = @import("list_blueprints.zig");
const list_data_automation_projects = @import("list_data_automation_projects.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_blueprint = @import("update_blueprint.zig");
const update_data_automation_project = @import("update_data_automation_project.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock Data Automation";

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

    /// Copies a Blueprint from one stage to another
    pub fn copyBlueprintStage(self: *Self, allocator: std.mem.Allocator, input: copy_blueprint_stage.CopyBlueprintStageInput, options: copy_blueprint_stage.Options) !copy_blueprint_stage.CopyBlueprintStageOutput {
        return copy_blueprint_stage.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Bedrock Data Automation Blueprint
    pub fn createBlueprint(self: *Self, allocator: std.mem.Allocator, input: create_blueprint.CreateBlueprintInput, options: create_blueprint.Options) !create_blueprint.CreateBlueprintOutput {
        return create_blueprint.execute(self, allocator, input, options);
    }

    /// Creates a new version of an existing Amazon Bedrock Data Automation
    /// Blueprint
    pub fn createBlueprintVersion(self: *Self, allocator: std.mem.Allocator, input: create_blueprint_version.CreateBlueprintVersionInput, options: create_blueprint_version.Options) !create_blueprint_version.CreateBlueprintVersionOutput {
        return create_blueprint_version.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Bedrock Data Automation Project
    pub fn createDataAutomationProject(self: *Self, allocator: std.mem.Allocator, input: create_data_automation_project.CreateDataAutomationProjectInput, options: create_data_automation_project.Options) !create_data_automation_project.CreateDataAutomationProjectOutput {
        return create_data_automation_project.execute(self, allocator, input, options);
    }

    /// Deletes an existing Amazon Bedrock Data Automation Blueprint
    pub fn deleteBlueprint(self: *Self, allocator: std.mem.Allocator, input: delete_blueprint.DeleteBlueprintInput, options: delete_blueprint.Options) !delete_blueprint.DeleteBlueprintOutput {
        return delete_blueprint.execute(self, allocator, input, options);
    }

    /// Deletes an existing Amazon Bedrock Data Automation Project
    pub fn deleteDataAutomationProject(self: *Self, allocator: std.mem.Allocator, input: delete_data_automation_project.DeleteDataAutomationProjectInput, options: delete_data_automation_project.Options) !delete_data_automation_project.DeleteDataAutomationProjectOutput {
        return delete_data_automation_project.execute(self, allocator, input, options);
    }

    /// Gets an existing Amazon Bedrock Data Automation Blueprint
    pub fn getBlueprint(self: *Self, allocator: std.mem.Allocator, input: get_blueprint.GetBlueprintInput, options: get_blueprint.Options) !get_blueprint.GetBlueprintOutput {
        return get_blueprint.execute(self, allocator, input, options);
    }

    /// API used to get blueprint optimization status.
    pub fn getBlueprintOptimizationStatus(self: *Self, allocator: std.mem.Allocator, input: get_blueprint_optimization_status.GetBlueprintOptimizationStatusInput, options: get_blueprint_optimization_status.Options) !get_blueprint_optimization_status.GetBlueprintOptimizationStatusOutput {
        return get_blueprint_optimization_status.execute(self, allocator, input, options);
    }

    /// Gets an existing Amazon Bedrock Data Automation Project
    pub fn getDataAutomationProject(self: *Self, allocator: std.mem.Allocator, input: get_data_automation_project.GetDataAutomationProjectInput, options: get_data_automation_project.Options) !get_data_automation_project.GetDataAutomationProjectOutput {
        return get_data_automation_project.execute(self, allocator, input, options);
    }

    /// Invoke an async job to perform Blueprint Optimization
    pub fn invokeBlueprintOptimizationAsync(self: *Self, allocator: std.mem.Allocator, input: invoke_blueprint_optimization_async.InvokeBlueprintOptimizationAsyncInput, options: invoke_blueprint_optimization_async.Options) !invoke_blueprint_optimization_async.InvokeBlueprintOptimizationAsyncOutput {
        return invoke_blueprint_optimization_async.execute(self, allocator, input, options);
    }

    /// Lists all existing Amazon Bedrock Data Automation Blueprints
    pub fn listBlueprints(self: *Self, allocator: std.mem.Allocator, input: list_blueprints.ListBlueprintsInput, options: list_blueprints.Options) !list_blueprints.ListBlueprintsOutput {
        return list_blueprints.execute(self, allocator, input, options);
    }

    /// Lists all existing Amazon Bedrock Data Automation Projects
    pub fn listDataAutomationProjects(self: *Self, allocator: std.mem.Allocator, input: list_data_automation_projects.ListDataAutomationProjectsInput, options: list_data_automation_projects.Options) !list_data_automation_projects.ListDataAutomationProjectsOutput {
        return list_data_automation_projects.execute(self, allocator, input, options);
    }

    /// List tags for an Amazon Bedrock Data Automation resource
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Tag an Amazon Bedrock Data Automation resource
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untag an Amazon Bedrock Data Automation resource
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Bedrock Data Automation Blueprint
    pub fn updateBlueprint(self: *Self, allocator: std.mem.Allocator, input: update_blueprint.UpdateBlueprintInput, options: update_blueprint.Options) !update_blueprint.UpdateBlueprintOutput {
        return update_blueprint.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Bedrock Data Automation Project
    pub fn updateDataAutomationProject(self: *Self, allocator: std.mem.Allocator, input: update_data_automation_project.UpdateDataAutomationProjectInput, options: update_data_automation_project.Options) !update_data_automation_project.UpdateDataAutomationProjectOutput {
        return update_data_automation_project.execute(self, allocator, input, options);
    }

    pub fn listBlueprintsPaginator(self: *Self, params: list_blueprints.ListBlueprintsInput) paginator.ListBlueprintsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataAutomationProjectsPaginator(self: *Self, params: list_data_automation_projects.ListDataAutomationProjectsInput) paginator.ListDataAutomationProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
