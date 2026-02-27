const ControlScope = @import("control_scope.zig").ControlScope;

/// Returns information about the control, including the scope of the control,
/// if enabled, and the Regions in which the control is available for
/// deployment. For more information about scope, see [Global
/// services](https://docs.aws.amazon.com/whitepapers/latest/aws-fault-isolation-boundaries/global-services.html).
///
/// If you are applying controls through an Amazon Web Services Control Tower
/// landing zone environment, remember that the values returned in the
/// `RegionConfiguration` API operation are not related to the governed Regions
/// in your landing zone. For example, if you are governing Regions `A`,`B`,and
/// `C` while the control is available in Regions `A`, `B`, C`,` and `D`, you'd
/// see a response with `DeployableRegions` of `A`, `B`, `C`, and `D` for a
/// control with `REGIONAL` scope, even though you may not intend to deploy the
/// control in Region `D`, because you do not govern it through your landing
/// zone.
pub const RegionConfiguration = struct {
    /// Regions in which the control is available to be deployed.
    deployable_regions: ?[]const []const u8,

    /// The coverage of the control, if deployed. Scope is an enumerated type, with
    /// value `Regional`, or `Global`. A control with Global scope is effective in
    /// all Amazon Web Services Regions, regardless of the Region from which it is
    /// enabled, or to which it is deployed. A control implemented by an SCP is
    /// usually Global in scope. A control with Regional scope has operations that
    /// are restricted specifically to the Region from which it is enabled and to
    /// which it is deployed. Controls implemented by Config rules and
    /// CloudFormation hooks usually are Regional in scope. Security Hub controls
    /// usually are Regional in scope.
    scope: ControlScope,

    pub const json_field_names = .{
        .deployable_regions = "DeployableRegions",
        .scope = "Scope",
    };
};
