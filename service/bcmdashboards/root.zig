pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_dashboard = @import("create_dashboard.zig");
pub const delete_dashboard = @import("delete_dashboard.zig");
pub const get_dashboard = @import("get_dashboard.zig");
pub const get_resource_policy = @import("get_resource_policy.zig");
pub const list_dashboards = @import("list_dashboards.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_dashboard = @import("update_dashboard.zig");
