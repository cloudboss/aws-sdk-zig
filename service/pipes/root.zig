pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const create_pipe = @import("create_pipe.zig");
pub const delete_pipe = @import("delete_pipe.zig");
pub const describe_pipe = @import("describe_pipe.zig");
pub const list_pipes = @import("list_pipes.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const start_pipe = @import("start_pipe.zig");
pub const stop_pipe = @import("stop_pipe.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_pipe = @import("update_pipe.zig");
