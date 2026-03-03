pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const CreateScalingPlanInput = @import("create_scaling_plan.zig").CreateScalingPlanInput;
pub const CreateScalingPlanOutput = @import("create_scaling_plan.zig").CreateScalingPlanOutput;
pub const DeleteScalingPlanInput = @import("delete_scaling_plan.zig").DeleteScalingPlanInput;
pub const DeleteScalingPlanOutput = @import("delete_scaling_plan.zig").DeleteScalingPlanOutput;
pub const DescribeScalingPlanResourcesInput = @import("describe_scaling_plan_resources.zig").DescribeScalingPlanResourcesInput;
pub const DescribeScalingPlanResourcesOutput = @import("describe_scaling_plan_resources.zig").DescribeScalingPlanResourcesOutput;
pub const DescribeScalingPlansInput = @import("describe_scaling_plans.zig").DescribeScalingPlansInput;
pub const DescribeScalingPlansOutput = @import("describe_scaling_plans.zig").DescribeScalingPlansOutput;
pub const GetScalingPlanResourceForecastDataInput = @import("get_scaling_plan_resource_forecast_data.zig").GetScalingPlanResourceForecastDataInput;
pub const GetScalingPlanResourceForecastDataOutput = @import("get_scaling_plan_resource_forecast_data.zig").GetScalingPlanResourceForecastDataOutput;
pub const UpdateScalingPlanInput = @import("update_scaling_plan.zig").UpdateScalingPlanInput;
pub const UpdateScalingPlanOutput = @import("update_scaling_plan.zig").UpdateScalingPlanOutput;
