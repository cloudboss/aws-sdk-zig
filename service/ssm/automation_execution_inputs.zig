const aws = @import("aws");

const TargetLocation = @import("target_location.zig").TargetLocation;
const Target = @import("target.zig").Target;

/// Information about the optional inputs that can be specified for an
/// automation execution
/// preview.
pub const AutomationExecutionInputs = struct {
    /// Information about parameters that can be specified for the preview
    /// operation.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// Information about the Amazon Web Services Regions and Amazon Web Services
    /// accounts targeted by the Automation execution
    /// preview operation.
    target_locations: ?[]const TargetLocation,

    /// A publicly accessible URL for a file that contains the `TargetLocations`
    /// body.
    /// Currently, only files in presigned Amazon S3 buckets are supported.
    target_locations_url: ?[]const u8,

    /// A key-value mapping of document parameters to target resources. Both Targets
    /// and TargetMaps
    /// can't be specified together.
    target_maps: ?[]const []const aws.map.MapEntry([]const []const u8),

    /// The name of the parameter used as the target resource for the
    /// rate-controlled execution.
    /// Required if you specify targets.
    target_parameter_name: ?[]const u8,

    /// Information about the resources that would be included in the actual runbook
    /// execution, if
    /// it were to be run. Both Targets and TargetMaps can't be specified together.
    targets: ?[]const Target,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .target_locations = "TargetLocations",
        .target_locations_url = "TargetLocationsURL",
        .target_maps = "TargetMaps",
        .target_parameter_name = "TargetParameterName",
        .targets = "Targets",
    };
};
