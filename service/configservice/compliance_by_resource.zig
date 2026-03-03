const Compliance = @import("compliance.zig").Compliance;

/// Indicates whether an Amazon Web Services resource that is evaluated
/// according
/// to one or more Config rules is compliant. A resource is
/// compliant if it complies with all of the rules that evaluate it. A
/// resource is noncompliant if it does not comply with one or more of
/// these rules.
pub const ComplianceByResource = struct {
    /// Indicates whether the Amazon Web Services resource complies with all of the
    /// Config rules that evaluated it.
    compliance: ?Compliance = null,

    /// The ID of the Amazon Web Services resource that was evaluated.
    resource_id: ?[]const u8 = null,

    /// The type of the Amazon Web Services resource that was evaluated.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance = "Compliance",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
