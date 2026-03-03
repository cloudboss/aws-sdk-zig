pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const DescribeStreamInput = @import("describe_stream.zig").DescribeStreamInput;
pub const DescribeStreamOutput = @import("describe_stream.zig").DescribeStreamOutput;
pub const GetRecordsInput = @import("get_records.zig").GetRecordsInput;
pub const GetRecordsOutput = @import("get_records.zig").GetRecordsOutput;
pub const GetShardIteratorInput = @import("get_shard_iterator.zig").GetShardIteratorInput;
pub const GetShardIteratorOutput = @import("get_shard_iterator.zig").GetShardIteratorOutput;
pub const ListStreamsInput = @import("list_streams.zig").ListStreamsInput;
pub const ListStreamsOutput = @import("list_streams.zig").ListStreamsOutput;
