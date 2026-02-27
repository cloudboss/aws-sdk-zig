pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_endpoint = @import("create_endpoint.zig");
pub const delete_endpoint = @import("delete_endpoint.zig");
pub const list_endpoints = @import("list_endpoints.zig");
pub const list_outposts_with_s3 = @import("list_outposts_with_s3.zig");
pub const list_shared_endpoints = @import("list_shared_endpoints.zig");
