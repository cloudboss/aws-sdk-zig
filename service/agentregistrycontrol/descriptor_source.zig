const DescriptorSourceFromUrl = @import("descriptor_source_from_url.zig").DescriptorSourceFromUrl;

/// The source configuration that defines where descriptor content is retrieved
/// from.
pub const DescriptorSource = struct {
    /// URL-based descriptor source, populated when descriptor content is
    /// synchronized from a URL.
    from_url: ?DescriptorSourceFromUrl = null,

    pub const json_field_names = .{
        .from_url = "fromUrl",
    };
};
