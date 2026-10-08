const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// A descriptor for a registry record that exposes an HTTP endpoint. This
/// descriptor is source-only: it identifies where the endpoint is located and
/// carries no descriptor payload data or schema version.
pub const HttpDescriptor = struct {
    /// The source location of the HTTP endpoint.
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
