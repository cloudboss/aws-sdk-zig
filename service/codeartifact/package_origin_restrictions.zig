const AllowPublish = @import("allow_publish.zig").AllowPublish;
const AllowUpstream = @import("allow_upstream.zig").AllowUpstream;

/// Details about the origin restrictions set on the package.
/// The package origin restrictions determine how new versions of a package
/// can be added to a specific repository.
pub const PackageOriginRestrictions = struct {
    /// The package origin configuration that determines if new versions of the
    /// package can be published directly to the repository.
    publish: AllowPublish,

    /// The package origin configuration that determines if new versions of the
    /// package can be added to the repository from an external connection or
    /// upstream source.
    upstream: AllowUpstream,

    pub const json_field_names = .{
        .publish = "publish",
        .upstream = "upstream",
    };
};
