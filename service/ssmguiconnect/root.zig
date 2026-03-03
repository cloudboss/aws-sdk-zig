pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const delete_connection_recording_preferences = @import("delete_connection_recording_preferences.zig");
pub const get_connection_recording_preferences = @import("get_connection_recording_preferences.zig");
pub const update_connection_recording_preferences = @import("update_connection_recording_preferences.zig");
