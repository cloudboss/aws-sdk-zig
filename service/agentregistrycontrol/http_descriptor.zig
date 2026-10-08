const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// A registry record descriptor for the HTTP protocol. This descriptor is
/// source-only: its content is synchronized from the configured source URL
/// rather than supplied inline.
pub const HttpDescriptor = struct {
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
