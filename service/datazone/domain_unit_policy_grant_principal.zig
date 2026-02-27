const DomainUnitDesignation = @import("domain_unit_designation.zig").DomainUnitDesignation;
const DomainUnitGrantFilter = @import("domain_unit_grant_filter.zig").DomainUnitGrantFilter;

/// The domain unit principal to whom the policy is granted.
pub const DomainUnitPolicyGrantPrincipal = struct {
    /// Specifes the designation of the domain unit users.
    domain_unit_designation: DomainUnitDesignation,

    /// The grant filter for the domain unit.
    domain_unit_grant_filter: ?DomainUnitGrantFilter,

    /// The ID of the domain unit.
    domain_unit_identifier: ?[]const u8,

    pub const json_field_names = .{
        .domain_unit_designation = "domainUnitDesignation",
        .domain_unit_grant_filter = "domainUnitGrantFilter",
        .domain_unit_identifier = "domainUnitIdentifier",
    };
};
