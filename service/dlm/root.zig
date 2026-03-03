pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const create_lifecycle_policy = @import("create_lifecycle_policy.zig");
pub const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
pub const get_lifecycle_policies = @import("get_lifecycle_policies.zig");
pub const get_lifecycle_policy = @import("get_lifecycle_policy.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_lifecycle_policy = @import("update_lifecycle_policy.zig");
