pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const GetGlyphsInput = @import("get_glyphs.zig").GetGlyphsInput;
pub const GetGlyphsOutput = @import("get_glyphs.zig").GetGlyphsOutput;
pub const GetSpritesInput = @import("get_sprites.zig").GetSpritesInput;
pub const GetSpritesOutput = @import("get_sprites.zig").GetSpritesOutput;
pub const GetStaticMapInput = @import("get_static_map.zig").GetStaticMapInput;
pub const GetStaticMapOutput = @import("get_static_map.zig").GetStaticMapOutput;
pub const GetStyleDescriptorInput = @import("get_style_descriptor.zig").GetStyleDescriptorInput;
pub const GetStyleDescriptorOutput = @import("get_style_descriptor.zig").GetStyleDescriptorOutput;
pub const GetTileInput = @import("get_tile.zig").GetTileInput;
pub const GetTileOutput = @import("get_tile.zig").GetTileOutput;
