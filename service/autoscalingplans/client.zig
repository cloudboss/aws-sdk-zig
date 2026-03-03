const aws = @import("aws");
const std = @import("std");

const create_scaling_plan = @import("create_scaling_plan.zig");
const delete_scaling_plan = @import("delete_scaling_plan.zig");
const describe_scaling_plan_resources = @import("describe_scaling_plan_resources.zig");
const describe_scaling_plans = @import("describe_scaling_plans.zig");
const get_scaling_plan_resource_forecast_data = @import("get_scaling_plan_resource_forecast_data.zig");
const update_scaling_plan = @import("update_scaling_plan.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Auto Scaling Plans";

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

    /// Creates a scaling plan.
    pub fn createScalingPlan(self: *Self, allocator: std.mem.Allocator, input: create_scaling_plan.CreateScalingPlanInput, options: create_scaling_plan.Options) !create_scaling_plan.CreateScalingPlanOutput {
        return create_scaling_plan.execute(self, allocator, input, options);
    }

    /// Deletes the specified scaling plan.
    ///
    /// Deleting a scaling plan deletes the underlying ScalingInstruction for
    /// all of the scalable resources that are covered by the plan.
    ///
    /// If the plan has launched resources or has scaling activities in progress,
    /// you must
    /// delete those resources separately.
    pub fn deleteScalingPlan(self: *Self, allocator: std.mem.Allocator, input: delete_scaling_plan.DeleteScalingPlanInput, options: delete_scaling_plan.Options) !delete_scaling_plan.DeleteScalingPlanOutput {
        return delete_scaling_plan.execute(self, allocator, input, options);
    }

    /// Describes the scalable resources in the specified scaling plan.
    pub fn describeScalingPlanResources(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_plan_resources.DescribeScalingPlanResourcesInput, options: describe_scaling_plan_resources.Options) !describe_scaling_plan_resources.DescribeScalingPlanResourcesOutput {
        return describe_scaling_plan_resources.execute(self, allocator, input, options);
    }

    /// Describes one or more of your scaling plans.
    pub fn describeScalingPlans(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_plans.DescribeScalingPlansInput, options: describe_scaling_plans.Options) !describe_scaling_plans.DescribeScalingPlansOutput {
        return describe_scaling_plans.execute(self, allocator, input, options);
    }

    /// Retrieves the forecast data for a scalable resource.
    ///
    /// Capacity forecasts are represented as predicted values, or data points, that
    /// are
    /// calculated using historical data points from a specified CloudWatch load
    /// metric. Data points are
    /// available for up to 56 days.
    pub fn getScalingPlanResourceForecastData(self: *Self, allocator: std.mem.Allocator, input: get_scaling_plan_resource_forecast_data.GetScalingPlanResourceForecastDataInput, options: get_scaling_plan_resource_forecast_data.Options) !get_scaling_plan_resource_forecast_data.GetScalingPlanResourceForecastDataOutput {
        return get_scaling_plan_resource_forecast_data.execute(self, allocator, input, options);
    }

    /// Updates the specified scaling plan.
    ///
    /// You cannot update a scaling plan if it is in the process of being created,
    /// updated, or
    /// deleted.
    pub fn updateScalingPlan(self: *Self, allocator: std.mem.Allocator, input: update_scaling_plan.UpdateScalingPlanInput, options: update_scaling_plan.Options) !update_scaling_plan.UpdateScalingPlanOutput {
        return update_scaling_plan.execute(self, allocator, input, options);
    }
};
