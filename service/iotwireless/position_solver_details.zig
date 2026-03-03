const SemtechGnssDetail = @import("semtech_gnss_detail.zig").SemtechGnssDetail;

/// The wrapper for position solver details.
pub const PositionSolverDetails = struct {
    /// The Semtech GNSS solver object details.
    semtech_gnss: ?SemtechGnssDetail = null,

    pub const json_field_names = .{
        .semtech_gnss = "SemtechGnss",
    };
};
