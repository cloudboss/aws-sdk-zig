pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const create_savings_plan = @import("create_savings_plan.zig");
pub const delete_queued_savings_plan = @import("delete_queued_savings_plan.zig");
pub const describe_savings_plan_rates = @import("describe_savings_plan_rates.zig");
pub const describe_savings_plans = @import("describe_savings_plans.zig");
pub const describe_savings_plans_offering_rates = @import("describe_savings_plans_offering_rates.zig");
pub const describe_savings_plans_offerings = @import("describe_savings_plans_offerings.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const return_savings_plan = @import("return_savings_plan.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
