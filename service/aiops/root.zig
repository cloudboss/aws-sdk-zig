pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const create_investigation_group = @import("create_investigation_group.zig");
pub const delete_investigation_group = @import("delete_investigation_group.zig");
pub const delete_investigation_group_policy = @import("delete_investigation_group_policy.zig");
pub const get_investigation_group = @import("get_investigation_group.zig");
pub const get_investigation_group_policy = @import("get_investigation_group_policy.zig");
pub const list_investigation_groups = @import("list_investigation_groups.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const put_investigation_group_policy = @import("put_investigation_group_policy.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_investigation_group = @import("update_investigation_group.zig");
