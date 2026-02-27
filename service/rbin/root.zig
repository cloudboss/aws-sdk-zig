pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_rule = @import("create_rule.zig");
pub const delete_rule = @import("delete_rule.zig");
pub const get_rule = @import("get_rule.zig");
pub const list_rules = @import("list_rules.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const lock_rule = @import("lock_rule.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const unlock_rule = @import("unlock_rule.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_rule = @import("update_rule.zig");
