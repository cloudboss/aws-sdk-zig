const LineageRunDetails = @import("lineage_run_details.zig").LineageRunDetails;

/// The details of a job run.
pub const JobRunDetails = union(enum) {
    /// The data lineage details of a job run.
    lineage_run_details: ?LineageRunDetails,

    pub const json_field_names = .{
        .lineage_run_details = "lineageRunDetails",
    };
};
