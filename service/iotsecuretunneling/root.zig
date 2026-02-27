pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const close_tunnel = @import("close_tunnel.zig");
pub const describe_tunnel = @import("describe_tunnel.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const list_tunnels = @import("list_tunnels.zig");
pub const open_tunnel = @import("open_tunnel.zig");
pub const rotate_tunnel_access_token = @import("rotate_tunnel_access_token.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
