const SelfGrantStatusDetail = @import("self_grant_status_detail.zig").SelfGrantStatusDetail;

/// The details of the self granting status.
pub const GlueSelfGrantStatusOutput = struct {
    /// The details for the self granting status for a Glue data source.
    self_grant_status_details: []const SelfGrantStatusDetail,

    pub const json_field_names = .{
        .self_grant_status_details = "selfGrantStatusDetails",
    };
};
