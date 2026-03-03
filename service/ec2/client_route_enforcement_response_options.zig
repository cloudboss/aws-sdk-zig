/// The current status of Client Route Enforcement.
pub const ClientRouteEnforcementResponseOptions = struct {
    /// Status of the client route enforcement feature, indicating whether Client
    /// Route Enforcement
    /// is `true` (enabled) or `false` (disabled).
    ///
    /// Valid values: `true | false`
    ///
    /// Default value: `false`
    enforced: ?bool = null,
};
