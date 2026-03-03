pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const DeleteObjectInput = @import("delete_object.zig").DeleteObjectInput;
pub const DeleteObjectOutput = @import("delete_object.zig").DeleteObjectOutput;
pub const DescribeObjectInput = @import("describe_object.zig").DescribeObjectInput;
pub const DescribeObjectOutput = @import("describe_object.zig").DescribeObjectOutput;
pub const GetObjectInput = @import("get_object.zig").GetObjectInput;
pub const GetObjectOutput = @import("get_object.zig").GetObjectOutput;
pub const ListItemsInput = @import("list_items.zig").ListItemsInput;
pub const ListItemsOutput = @import("list_items.zig").ListItemsOutput;
pub const PutObjectInput = @import("put_object.zig").PutObjectInput;
pub const PutObjectOutput = @import("put_object.zig").PutObjectOutput;
