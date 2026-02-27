const DomainEntry = @import("domain_entry.zig").DomainEntry;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const RegisteredDomainDelegationInfo = @import("registered_domain_delegation_info.zig").RegisteredDomainDelegationInfo;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// Describes a domain where you are storing recordsets.
pub const Domain = struct {
    /// The Amazon Resource Name (ARN) of the domain recordset
    /// (`arn:aws:lightsail:global:123456789101:Domain/824cede0-abc7-4f84-8dbc-12345EXAMPLE`).
    arn: ?[]const u8,

    /// The date when the domain recordset was created.
    created_at: ?i64,

    /// An array of key-value pairs containing information about the domain entries.
    domain_entries: ?[]const DomainEntry,

    /// The AWS Region and Availability Zones where the domain recordset was
    /// created.
    location: ?ResourceLocation,

    /// The name of the domain.
    name: ?[]const u8,

    /// An object that describes the state of the Route 53 domain delegation to a
    /// Lightsail DNS zone.
    registered_domain_delegation_info: ?RegisteredDomainDelegationInfo,

    /// The resource type.
    resource_type: ?ResourceType,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// an instance or another resource in Lightsail. This code enables our support
    /// team to look up
    /// your Lightsail information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .domain_entries = "domainEntries",
        .location = "location",
        .name = "name",
        .registered_domain_delegation_info = "registeredDomainDelegationInfo",
        .resource_type = "resourceType",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
