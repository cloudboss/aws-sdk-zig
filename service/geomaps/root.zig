pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const get_glyphs = @import("get_glyphs.zig");
pub const get_sprites = @import("get_sprites.zig");
pub const get_static_map = @import("get_static_map.zig");
pub const get_style_descriptor = @import("get_style_descriptor.zig");
pub const get_tile = @import("get_tile.zig");
