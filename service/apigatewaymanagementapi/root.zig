pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const DeleteConnectionInput = @import("delete_connection.zig").DeleteConnectionInput;
pub const GetConnectionInput = @import("get_connection.zig").GetConnectionInput;
pub const GetConnectionOutput = @import("get_connection.zig").GetConnectionOutput;
pub const PostToConnectionInput = @import("post_to_connection.zig").PostToConnectionInput;
