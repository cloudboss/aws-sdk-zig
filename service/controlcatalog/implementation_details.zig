/// An object that describes the implementation type for a control.
///
/// Our `ImplementationDetails` `Type` format has three required segments:
///
/// * `SERVICE-PROVIDER::SERVICE-NAME::RESOURCE-NAME`
///
/// For example, `AWS::Config::ConfigRule` **or**
/// `AWS::SecurityHub::SecurityControl` resources have the format with three
/// required segments.
///
/// Our `ImplementationDetails` `Type` format has an optional fourth segment,
/// which is present for applicable implementation types. The format is as
/// follows:
///
/// * `SERVICE-PROVIDER::SERVICE-NAME::RESOURCE-NAME::RESOURCE-TYPE-DESCRIPTION`
///
/// For example, `AWS::Organizations::Policy::SERVICE_CONTROL_POLICY` **or**
/// `AWS::CloudFormation::Type::HOOK` have the format with four segments.
///
/// Although the format is similar, the values for the `Type` field do not match
/// any Amazon Web Services CloudFormation values.
pub const ImplementationDetails = struct {
    /// A service-specific identifier for the control, assigned by the service that
    /// implemented the control. For example, this identifier could be an Amazon Web
    /// Services Config Rule ID or a Security Hub Control ID.
    identifier: ?[]const u8,

    /// A string that describes a control's implementation type.
    type: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .type = "Type",
    };
};
