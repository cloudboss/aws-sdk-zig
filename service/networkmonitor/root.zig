pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_monitor = @import("create_monitor.zig");
pub const create_probe = @import("create_probe.zig");
pub const delete_monitor = @import("delete_monitor.zig");
pub const delete_probe = @import("delete_probe.zig");
pub const get_monitor = @import("get_monitor.zig");
pub const get_probe = @import("get_probe.zig");
pub const list_monitors = @import("list_monitors.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_monitor = @import("update_monitor.zig");
pub const update_probe = @import("update_probe.zig");
