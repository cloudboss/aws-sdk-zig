pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const get_records = @import("get_records.zig");
pub const get_shard_iterator = @import("get_shard_iterator.zig");
pub const get_stream = @import("get_stream.zig");
pub const list_streams = @import("list_streams.zig");
