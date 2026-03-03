const aws = @import("aws");

/// An object in a list that represents a domain.
pub const ListDomainItem = struct {
    /// The timestamp of when the domain was created.
    created_at: i64,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// The timestamp of when the domain was most recently edited.
    last_updated_at: i64,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .last_updated_at = "LastUpdatedAt",
        .tags = "Tags",
    };
};
