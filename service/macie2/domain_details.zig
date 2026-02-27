/// Provides information about the domain name of the device that an entity used
/// to perform an action on an affected resource.
pub const DomainDetails = struct {
    /// The name of the domain.
    domain_name: ?[]const u8,

    pub const json_field_names = .{
        .domain_name = "domainName",
    };
};
