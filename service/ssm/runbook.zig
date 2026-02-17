const aws = @import("aws");

const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;

/// Information about an Automation runbook used in a runbook workflow in Change
/// Manager.
///
/// The Automation runbooks specified for the runbook workflow can't run until
/// all required
/// approvals for the change request have been received.
pub const Runbook = struct {
    /// The name of the Automation runbook used in a runbook workflow.
    document_name: []const u8,

    /// The version of the Automation runbook used in a runbook workflow.
    document_version: ?[]const u8,

    /// The `MaxConcurrency` value specified by the user when the operation started,
    /// indicating the maximum number of resources that the runbook operation can
    /// run on at the same
    /// time.
    max_concurrency: ?[]const u8,

    /// The `MaxErrors` value specified by the user when the execution started,
    /// indicating the maximum number of errors that can occur during the operation
    /// before the updates
    /// are stopped or rolled back.
    max_errors: ?[]const u8,

    /// The key-value map of execution parameters, which were supplied when calling
    /// `StartChangeRequestExecution`.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// Information about the Amazon Web Services Regions and Amazon Web Services
    /// accounts targeted by the current Runbook
    /// operation.
    target_locations: ?[]const TargetLocation,

    /// A key-value mapping of runbook parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The name of the parameter used as the target resource for the
    /// rate-controlled
    /// runbook workflow. Required if you specify `Targets`.
    target_parameter_name: ?[]const u8,

    /// A key-value mapping to target resources that the runbook operation performs
    /// tasks on.
    /// Required if you specify `TargetParameterName`.
    targets: ?[]const Target,

    pub const json_field_names = .{
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .parameters = "Parameters",
        .target_locations = "TargetLocations",
        .target_maps = "TargetMaps",
        .target_parameter_name = "TargetParameterName",
        .targets = "Targets",
    };
};
