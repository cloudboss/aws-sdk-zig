const ActivationOverrideBehavior = @import("activation_override_behavior.zig").ActivationOverrideBehavior;

/// The options you can specify when you create a new version of a grant, such
/// as activation
/// override behavior. For more information, see [Granted licenses in License
/// Manager](https://docs.aws.amazon.com/license-manager/latest/userguide/granted-licenses.html) in the *License Manager User Guide*.
pub const Options = struct {
    /// An activation option for your grant that determines the behavior of
    /// activating a grant.
    /// Activation options can only be used with granted licenses sourced from the
    /// Amazon Web Services Marketplace. Additionally, the operation must specify
    /// the value of `ACTIVE` for the
    /// `Status` parameter.
    ///
    /// * As a license administrator, you can optionally specify an
    /// `ActivationOverrideBehavior` when activating a grant.
    ///
    /// * As a grantor, you can optionally specify an
    /// `ActivationOverrideBehavior` when you activate a grant for a grantee
    /// account in your organization.
    ///
    /// * As a grantee, if the grantor creating the distributed grant doesn’t
    ///   specify an
    /// `ActivationOverrideBehavior`, you can optionally specify one when you
    /// are activating the grant.
    ///
    /// **DISTRIBUTED_GRANTS_ONLY**
    ///
    /// Use this value to activate a grant without replacing any member account’s
    /// active grants for the same product.
    ///
    /// **ALL_GRANTS_PERMITTED_BY_ISSUER**
    ///
    /// Use this value to activate a grant and disable other active grants in any
    /// member accounts for the same product. This action will also replace their
    /// previously activated grants with this activated grant.
    activation_override_behavior: ?ActivationOverrideBehavior,

    pub const json_field_names = .{
        .activation_override_behavior = "ActivationOverrideBehavior",
    };
};
