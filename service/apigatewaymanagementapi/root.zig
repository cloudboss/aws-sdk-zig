pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const delete_connection = @import("delete_connection.zig");
pub const get_connection = @import("get_connection.zig");
pub const post_to_connection = @import("post_to_connection.zig");
