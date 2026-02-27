const OptInStatus = @import("opt_in_status.zig").OptInStatus;

/// Information about whether DevOps Guru is configured to create an OpsItem in
/// Amazon Web Services Systems Manager
/// OpsCenter for each created insight. You can use this to update the
/// configuration.
pub const OpsCenterIntegrationConfig = struct {
    /// Specifies if DevOps Guru is enabled to create an Amazon Web Services Systems
    /// Manager OpsItem for each created
    /// insight.
    opt_in_status: ?OptInStatus,

    pub const json_field_names = .{
        .opt_in_status = "OptInStatus",
    };
};
