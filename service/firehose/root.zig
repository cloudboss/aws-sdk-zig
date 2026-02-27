pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const create_delivery_stream = @import("create_delivery_stream.zig");
pub const delete_delivery_stream = @import("delete_delivery_stream.zig");
pub const describe_delivery_stream = @import("describe_delivery_stream.zig");
pub const list_delivery_streams = @import("list_delivery_streams.zig");
pub const list_tags_for_delivery_stream = @import("list_tags_for_delivery_stream.zig");
pub const put_record = @import("put_record.zig");
pub const put_record_batch = @import("put_record_batch.zig");
pub const start_delivery_stream_encryption = @import("start_delivery_stream_encryption.zig");
pub const stop_delivery_stream_encryption = @import("stop_delivery_stream_encryption.zig");
pub const tag_delivery_stream = @import("tag_delivery_stream.zig");
pub const untag_delivery_stream = @import("untag_delivery_stream.zig");
pub const update_destination = @import("update_destination.zig");
