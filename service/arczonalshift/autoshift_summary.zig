const AutoshiftExecutionStatus = @import("autoshift_execution_status.zig").AutoshiftExecutionStatus;

/// Information about an autoshift. Amazon Web Services starts an autoshift to
/// temporarily move traffic for a resource away from an Availability Zone in an
/// Amazon Web Services Region when Amazon Web Services determines that there's
/// an issue in the Availability Zone that could potentially affect customers.
/// You can configure zonal autoshift in ARC for managed resources in your
/// Amazon Web Services account in a Region. Supported Amazon Web Services
/// resources are automatically registered with ARC.
///
/// Autoshifts are temporary. When the Availability Zone recovers, Amazon Web
/// Services ends the autoshift, and traffic for the resource is no longer
/// directed to the other Availability Zones in the Region.
///
/// You can stop an autoshift for a resource by disabling zonal autoshift.
pub const AutoshiftSummary = struct {
    /// The Availability Zone (for example, `use1-az1`) that traffic is shifted away
    /// from for a resource when Amazon Web Services starts an autoshift. Until the
    /// autoshift ends, traffic for the resource is instead directed to other
    /// Availability Zones in the Amazon Web Services Region. An autoshift can end
    /// for a resource, for example, when Amazon Web Services ends the autoshift for
    /// the Availability Zone or when you disable zonal autoshift for the resource.
    away_from: []const u8,

    /// The time (in UTC) when the autoshift ended.
    end_time: ?i64,

    /// The time (in UTC) when the autoshift started.
    start_time: i64,

    /// The status for an autoshift.
    status: AutoshiftExecutionStatus,

    pub const json_field_names = .{
        .away_from = "awayFrom",
        .end_time = "endTime",
        .start_time = "startTime",
        .status = "status",
    };
};
