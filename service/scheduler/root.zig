pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_schedule = @import("create_schedule.zig");
pub const create_schedule_group = @import("create_schedule_group.zig");
pub const delete_schedule = @import("delete_schedule.zig");
pub const delete_schedule_group = @import("delete_schedule_group.zig");
pub const get_schedule = @import("get_schedule.zig");
pub const get_schedule_group = @import("get_schedule_group.zig");
pub const list_schedule_groups = @import("list_schedule_groups.zig");
pub const list_schedules = @import("list_schedules.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_schedule = @import("update_schedule.zig");
