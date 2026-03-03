pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const create_rescore_execution_plan = @import("create_rescore_execution_plan.zig");
pub const delete_rescore_execution_plan = @import("delete_rescore_execution_plan.zig");
pub const describe_rescore_execution_plan = @import("describe_rescore_execution_plan.zig");
pub const list_rescore_execution_plans = @import("list_rescore_execution_plans.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const rescore = @import("rescore.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_rescore_execution_plan = @import("update_rescore_execution_plan.zig");
