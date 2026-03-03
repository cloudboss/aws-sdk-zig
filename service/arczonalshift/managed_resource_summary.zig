const aws = @import("aws");

const AutoshiftInResource = @import("autoshift_in_resource.zig").AutoshiftInResource;
const ZonalAutoshiftStatus = @import("zonal_autoshift_status.zig").ZonalAutoshiftStatus;
const ZonalShiftInResource = @import("zonal_shift_in_resource.zig").ZonalShiftInResource;

/// A complex structure for a managed resource in an Amazon Web Services account
/// with information about zonal shifts and autoshifts.
///
/// You can start a zonal shift in ARC for a managed resource to temporarily
/// move traffic for the resource away from an Availability Zone in an Amazon
/// Web Services Region. You can also configure zonal autoshift for a managed
/// resource.
///
/// At this time, managed resources are Amazon EC2 Auto Scaling groups, Amazon
/// Elastic Kubernetes Service, Network Load Balancers, and Application Load
/// Balancer.
pub const ManagedResourceSummary = struct {
    /// A collection of key-value pairs that indicate whether resources are active
    /// in Availability Zones or not. The key name is the Availability Zone where
    /// the resource is deployed. The value is 1 or 0.
    applied_weights: ?[]const aws.map.MapEntry(f32) = null,

    /// The Amazon Resource Name (ARN) for the managed resource.
    arn: ?[]const u8 = null,

    /// An array of the autoshifts that have been completed for a resource.
    autoshifts: ?[]const AutoshiftInResource = null,

    /// The Availability Zones that a resource is deployed in.
    availability_zones: []const []const u8,

    /// The name of the managed resource.
    name: ?[]const u8 = null,

    /// This status tracks whether a practice run configuration exists for a
    /// resource. When you configure a practice run for a resource so that a
    /// practice run configuration exists, ARC sets this value to `ENABLED`. If a
    /// you have not configured a practice run for the resource, or delete a
    /// practice run configuration, ARC sets the value to `DISABLED`.
    ///
    /// ARC updates this status; you can't set a practice run status to `ENABLED` or
    /// `DISABLED`.
    practice_run_status: ?ZonalAutoshiftStatus = null,

    /// The status of autoshift for a resource. When you configure zonal autoshift
    /// for a resource, you can set the value of the status to `ENABLED` or
    /// `DISABLED`.
    zonal_autoshift_status: ?ZonalAutoshiftStatus = null,

    /// An array of the zonal shifts for a resource.
    zonal_shifts: ?[]const ZonalShiftInResource = null,

    pub const json_field_names = .{
        .applied_weights = "appliedWeights",
        .arn = "arn",
        .autoshifts = "autoshifts",
        .availability_zones = "availabilityZones",
        .name = "name",
        .practice_run_status = "practiceRunStatus",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
        .zonal_shifts = "zonalShifts",
    };
};
