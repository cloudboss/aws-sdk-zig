pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const send_serial_console_ssh_public_key = @import("send_serial_console_ssh_public_key.zig");
pub const send_ssh_public_key = @import("send_ssh_public_key.zig");
