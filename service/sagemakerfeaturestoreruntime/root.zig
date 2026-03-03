pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const batch_get_record = @import("batch_get_record.zig");
pub const delete_record = @import("delete_record.zig");
pub const get_record = @import("get_record.zig");
pub const put_record = @import("put_record.zig");
