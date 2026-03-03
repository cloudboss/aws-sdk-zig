const ExportEnvironment = @import("export_environment.zig").ExportEnvironment;

/// Describes an instance to export.
pub const InstanceExportDetails = struct {
    /// The ID of the resource being exported.
    instance_id: ?[]const u8 = null,

    /// The target virtualization environment.
    target_environment: ?ExportEnvironment = null,
};
