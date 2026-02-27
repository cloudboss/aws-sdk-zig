const DomainUnitTarget = @import("domain_unit_target.zig").DomainUnitTarget;

/// The target of the rule.
pub const RuleTarget = union(enum) {
    /// The ID of the domain unit.
    domain_unit_target: ?DomainUnitTarget,

    pub const json_field_names = .{
        .domain_unit_target = "domainUnitTarget",
    };
};
