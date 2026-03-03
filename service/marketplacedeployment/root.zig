pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const put_deployment_parameter = @import("put_deployment_parameter.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
