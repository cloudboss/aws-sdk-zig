const aws = @import("aws");

const AccessAssociationSourceType = @import("access_association_source_type.zig").AccessAssociationSourceType;

/// Represents a domain name access association between an access association
/// source and a private custom domain name. With a domain name access
/// association, an access association source can invoke a private custom domain
/// name while isolated from the public internet.
pub const DomainNameAccessAssociation = struct {
    /// The ARN of the domain name access association source. For a VPCE, the ARN
    /// must be a VPC endpoint.
    access_association_source: ?[]const u8,

    /// The type of the domain name access association source.
    access_association_source_type: ?AccessAssociationSourceType,

    /// The ARN of the domain name access association resource.
    domain_name_access_association_arn: ?[]const u8,

    /// The ARN of the domain name.
    domain_name_arn: ?[]const u8,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .access_association_source = "accessAssociationSource",
        .access_association_source_type = "accessAssociationSourceType",
        .domain_name_access_association_arn = "domainNameAccessAssociationArn",
        .domain_name_arn = "domainNameArn",
        .tags = "tags",
    };
};
