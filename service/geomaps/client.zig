const aws = @import("aws");
const std = @import("std");

const get_glyphs = @import("get_glyphs.zig");
const get_sprites = @import("get_sprites.zig");
const get_static_map = @import("get_static_map.zig");
const get_style_descriptor = @import("get_style_descriptor.zig");
const get_tile = @import("get_tile.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Geo Maps";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// `GetGlyphs` returns the map's glyphs.
    ///
    /// For more information, see [Style labels with
    /// glyphs](https://docs.aws.amazon.com/location/latest/developerguide/styling-labels-with-glyphs.html) in the *Amazon Location Service Developer Guide*.
    pub fn getGlyphs(self: *Self, allocator: std.mem.Allocator, input: get_glyphs.GetGlyphsInput, options: get_glyphs.Options) !get_glyphs.GetGlyphsOutput {
        return get_glyphs.execute(self, allocator, input, options);
    }

    /// `GetSprites` returns the map's sprites.
    ///
    /// For more information, see [Style iconography with
    /// sprites](https://docs.aws.amazon.com/location/latest/developerguide/styling-iconography-with-sprites.html) in the *Amazon Location Service Developer Guide*.
    pub fn getSprites(self: *Self, allocator: std.mem.Allocator, input: get_sprites.GetSpritesInput, options: get_sprites.Options) !get_sprites.GetSpritesOutput {
        return get_sprites.execute(self, allocator, input, options);
    }

    /// `GetStaticMap` provides high-quality static map images with customizable
    /// options. You can modify the map's appearance and overlay additional
    /// information. It's an ideal solution for applications requiring tailored
    /// static map snapshots.
    ///
    /// For more information, see the following topics in the *Amazon Location
    /// Service Developer Guide*:
    ///
    /// * [Static
    ///   maps](https://docs.aws.amazon.com/location/latest/developerguide/static-maps.html)
    /// * [Customize static
    ///   maps](https://docs.aws.amazon.com/location/latest/developerguide/customizing-static-maps.html)
    /// * [Overlay on the static
    ///   map](https://docs.aws.amazon.com/location/latest/developerguide/overlaying-static-map.html)
    pub fn getStaticMap(self: *Self, allocator: std.mem.Allocator, input: get_static_map.GetStaticMapInput, options: get_static_map.Options) !get_static_map.GetStaticMapOutput {
        return get_static_map.execute(self, allocator, input, options);
    }

    /// `GetStyleDescriptor` returns information about the style.
    ///
    /// For more information, see [Style dynamic
    /// maps](https://docs.aws.amazon.com/location/latest/developerguide/styling-dynamic-maps.html) in the *Amazon Location Service Developer Guide*.
    pub fn getStyleDescriptor(self: *Self, allocator: std.mem.Allocator, input: get_style_descriptor.GetStyleDescriptorInput, options: get_style_descriptor.Options) !get_style_descriptor.GetStyleDescriptorOutput {
        return get_style_descriptor.execute(self, allocator, input, options);
    }

    /// `GetTile` returns a tile. Map tiles are used by clients to render a map.
    /// they're addressed using a grid arrangement with an X coordinate, Y
    /// coordinate, and Z (zoom) level.
    ///
    /// For more information, see
    /// [Tiles](https://docs.aws.amazon.com/location/latest/developerguide/tiles.html) in the *Amazon Location Service Developer Guide*.
    pub fn getTile(self: *Self, allocator: std.mem.Allocator, input: get_tile.GetTileInput, options: get_tile.Options) !get_tile.GetTileOutput {
        return get_tile.execute(self, allocator, input, options);
    }
};
