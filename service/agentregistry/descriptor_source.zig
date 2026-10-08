const DescriptorSourceFromUrl = @import("descriptor_source_from_url.zig").DescriptorSourceFromUrl;

/// The source location from which a descriptor's content was retrieved.
pub const DescriptorSource = struct {
    /// The URL-based descriptor source, populated when descriptor content is
    /// synchronized from a URL.
    from_url: ?DescriptorSourceFromUrl = null,

    pub const json_field_names = .{
        .from_url = "fromUrl",
    };
};
