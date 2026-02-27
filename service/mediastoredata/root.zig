pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const delete_object = @import("delete_object.zig");
pub const describe_object = @import("describe_object.zig");
pub const get_object = @import("get_object.zig");
pub const list_items = @import("list_items.zig");
pub const put_object = @import("put_object.zig");
