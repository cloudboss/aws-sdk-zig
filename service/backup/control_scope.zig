const aws = @import("aws");

/// A framework consists of one or more controls. Each control has its own
/// control scope.
/// The control scope can include one or more resource types, a combination of a
/// tag key and
/// value, or a combination of one resource type and one resource ID. If no
/// scope is specified,
/// evaluations for the rule are triggered when any resource in your recording
/// group changes in
/// configuration.
///
/// To set a control scope that includes all of a particular resource, leave the
/// `ControlScope` empty or do not pass it when calling
/// `CreateFramework`.
pub const ControlScope = struct {
    /// The ID of the only Amazon Web Services resource that you want your control
    /// scope to
    /// contain.
    compliance_resource_ids: ?[]const []const u8 = null,

    /// Describes whether the control scope includes one or more types of resources,
    /// such as
    /// `EFS` or `RDS`.
    compliance_resource_types: ?[]const []const u8 = null,

    /// The tag key-value pair applied to those Amazon Web Services resources that
    /// you want to
    /// trigger an evaluation for a rule. A maximum of one key-value pair can be
    /// provided. The tag
    /// value is optional, but it cannot be an empty string if you are creating or
    /// editing a
    /// framework from the console (though the value can be an empty string when
    /// included
    /// in a CloudFormation template).
    ///
    /// The structure to assign a tag is:
    /// `[{"Key":"string","Value":"string"}]`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compliance_resource_ids = "ComplianceResourceIds",
        .compliance_resource_types = "ComplianceResourceTypes",
        .tags = "Tags",
    };
};
