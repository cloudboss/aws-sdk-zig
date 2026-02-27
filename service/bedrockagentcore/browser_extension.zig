const ResourceLocation = @import("resource_location.zig").ResourceLocation;

/// Browser extension configuration.
pub const BrowserExtension = struct {
    /// The location where the browser extension files are stored. This specifies
    /// the source from which the extension will be loaded and installed.
    location: ResourceLocation,

    pub const json_field_names = .{
        .location = "location",
    };
};
