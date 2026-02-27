pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_export = @import("create_export.zig");
pub const delete_export = @import("delete_export.zig");
pub const get_execution = @import("get_execution.zig");
pub const get_export = @import("get_export.zig");
pub const get_table = @import("get_table.zig");
pub const list_executions = @import("list_executions.zig");
pub const list_exports = @import("list_exports.zig");
pub const list_tables = @import("list_tables.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_export = @import("update_export.zig");
