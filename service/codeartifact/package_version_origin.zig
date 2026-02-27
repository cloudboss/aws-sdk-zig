const DomainEntryPoint = @import("domain_entry_point.zig").DomainEntryPoint;
const PackageVersionOriginType = @import("package_version_origin_type.zig").PackageVersionOriginType;

/// Information about how a package version was added to a repository.
pub const PackageVersionOrigin = struct {
    /// A
    /// [DomainEntryPoint](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_DomainEntryPoint.html) object that contains
    /// information about from which repository or external connection the package
    /// version was added to the domain.
    domain_entry_point: ?DomainEntryPoint,

    /// Describes how the package version was originally added to the domain. An
    /// `INTERNAL` origin type means the package version was published
    /// directly to a repository in the domain. An `EXTERNAL` origin type means the
    /// package version was ingested from an external connection.
    origin_type: ?PackageVersionOriginType,

    pub const json_field_names = .{
        .domain_entry_point = "domainEntryPoint",
        .origin_type = "originType",
    };
};
