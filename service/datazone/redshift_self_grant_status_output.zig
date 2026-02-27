const SelfGrantStatusDetail = @import("self_grant_status_detail.zig").SelfGrantStatusDetail;

/// The details for the self granting status for an Amazon Redshift data source.
pub const RedshiftSelfGrantStatusOutput = struct {
    /// The details for the self granting status for an Amazon Redshift data source.
    self_grant_status_details: []const SelfGrantStatusDetail,

    pub const json_field_names = .{
        .self_grant_status_details = "selfGrantStatusDetails",
    };
};
