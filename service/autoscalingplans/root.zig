pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const create_scaling_plan = @import("create_scaling_plan.zig");
pub const delete_scaling_plan = @import("delete_scaling_plan.zig");
pub const describe_scaling_plan_resources = @import("describe_scaling_plan_resources.zig");
pub const describe_scaling_plans = @import("describe_scaling_plans.zig");
pub const get_scaling_plan_resource_forecast_data = @import("get_scaling_plan_resource_forecast_data.zig");
pub const update_scaling_plan = @import("update_scaling_plan.zig");
