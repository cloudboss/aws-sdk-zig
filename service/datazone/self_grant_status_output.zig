const GlueSelfGrantStatusOutput = @import("glue_self_grant_status_output.zig").GlueSelfGrantStatusOutput;
const RedshiftSelfGrantStatusOutput = @import("redshift_self_grant_status_output.zig").RedshiftSelfGrantStatusOutput;

/// The details for the self granting status for a data source.
pub const SelfGrantStatusOutput = union(enum) {
    /// The details for the self granting status for a Glue data source.
    glue_self_grant_status: ?GlueSelfGrantStatusOutput,
    /// The details for the self granting status for an Amazon Redshift data source.
    redshift_self_grant_status: ?RedshiftSelfGrantStatusOutput,

    pub const json_field_names = .{
        .glue_self_grant_status = "glueSelfGrantStatus",
        .redshift_self_grant_status = "redshiftSelfGrantStatus",
    };
};
