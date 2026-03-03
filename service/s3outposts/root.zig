pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const CreateEndpointInput = @import("create_endpoint.zig").CreateEndpointInput;
pub const CreateEndpointOutput = @import("create_endpoint.zig").CreateEndpointOutput;
pub const DeleteEndpointInput = @import("delete_endpoint.zig").DeleteEndpointInput;
pub const ListEndpointsInput = @import("list_endpoints.zig").ListEndpointsInput;
pub const ListEndpointsOutput = @import("list_endpoints.zig").ListEndpointsOutput;
pub const ListOutpostsWithS3Input = @import("list_outposts_with_s3.zig").ListOutpostsWithS3Input;
pub const ListOutpostsWithS3Output = @import("list_outposts_with_s3.zig").ListOutpostsWithS3Output;
pub const ListSharedEndpointsInput = @import("list_shared_endpoints.zig").ListSharedEndpointsInput;
pub const ListSharedEndpointsOutput = @import("list_shared_endpoints.zig").ListSharedEndpointsOutput;
