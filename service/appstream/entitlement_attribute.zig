/// An attribute associated with an entitlement. Application entitlements work
/// by matching
/// a supported SAML 2.0 attribute name to a value when a user identity
/// federates to a WorkSpaces Applications SAML application.
pub const EntitlementAttribute = struct {
    /// A supported AWS IAM SAML `PrincipalTag` attribute that is matched to the
    /// associated value when a user identity federates into a WorkSpaces
    /// Applications SAML
    /// application.
    ///
    /// The following are valid values:
    ///
    /// * roles
    ///
    /// * department
    ///
    /// * organization
    ///
    /// * groups
    ///
    /// * title
    ///
    /// * costCenter
    ///
    /// * userType
    name: []const u8,

    /// A value that is matched to a supported SAML attribute name when a user
    /// identity
    /// federates into a WorkSpaces Applications SAML application.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
