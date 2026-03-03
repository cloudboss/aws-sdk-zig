const ControlOperationType = @import("control_operation_type.zig").ControlOperationType;
const ControlOperationStatus = @import("control_operation_status.zig").ControlOperationStatus;

/// A filter object that lets you call `ListControlOperations` with a specific
/// filter.
pub const ControlOperationFilter = struct {
    /// The set of `controlIdentifier` returned by the filter.
    control_identifiers: ?[]const []const u8 = null,

    /// The set of `ControlOperation` objects returned by the filter.
    control_operation_types: ?[]const ControlOperationType = null,

    /// The set `controlIdentifier` of enabled controls selected by the filter.
    enabled_control_identifiers: ?[]const []const u8 = null,

    /// Lists the status of control operations.
    statuses: ?[]const ControlOperationStatus = null,

    /// The set of `targetIdentifier` objects returned by the filter.
    target_identifiers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .control_identifiers = "controlIdentifiers",
        .control_operation_types = "controlOperationTypes",
        .enabled_control_identifiers = "enabledControlIdentifiers",
        .statuses = "statuses",
        .target_identifiers = "targetIdentifiers",
    };
};
