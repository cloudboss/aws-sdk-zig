const Table = @import("table.zig").Table;
const ViewValidation = @import("view_validation.zig").ViewValidation;

/// A structure containing information about an asynchronous change to a table.
pub const StatusDetails = struct {
    /// A `Table` object representing the requested changes.
    requested_change: ?*Table = null,

    /// A list of `ViewValidation` objects that contain information for an
    /// analytical engine to validate a view.
    view_validations: ?[]const ViewValidation = null,

    pub const json_field_names = .{
        .requested_change = "RequestedChange",
        .view_validations = "ViewValidations",
    };
};
