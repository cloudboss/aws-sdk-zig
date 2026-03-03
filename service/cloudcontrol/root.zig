pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const waiters = @import("waiters.zig");
pub const types = @import("types.zig");

pub const cancel_resource_request = @import("cancel_resource_request.zig");
pub const create_resource = @import("create_resource.zig");
pub const delete_resource = @import("delete_resource.zig");
pub const get_resource = @import("get_resource.zig");
pub const get_resource_request_status = @import("get_resource_request_status.zig");
pub const list_resource_requests = @import("list_resource_requests.zig");
pub const list_resources = @import("list_resources.zig");
pub const update_resource = @import("update_resource.zig");
