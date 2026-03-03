pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const InvokeEndpointWithBidirectionalStreamInput = @import("invoke_endpoint_with_bidirectional_stream.zig").InvokeEndpointWithBidirectionalStreamInput;
pub const InvokeEndpointWithBidirectionalStreamOutput = @import("invoke_endpoint_with_bidirectional_stream.zig").InvokeEndpointWithBidirectionalStreamOutput;
