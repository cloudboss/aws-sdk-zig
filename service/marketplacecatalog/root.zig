pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const batch_describe_entities = @import("batch_describe_entities.zig");
pub const cancel_change_set = @import("cancel_change_set.zig");
pub const delete_resource_policy = @import("delete_resource_policy.zig");
pub const describe_change_set = @import("describe_change_set.zig");
pub const describe_entity = @import("describe_entity.zig");
pub const get_resource_policy = @import("get_resource_policy.zig");
pub const list_change_sets = @import("list_change_sets.zig");
pub const list_entities = @import("list_entities.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const put_resource_policy = @import("put_resource_policy.zig");
pub const start_change_set = @import("start_change_set.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
