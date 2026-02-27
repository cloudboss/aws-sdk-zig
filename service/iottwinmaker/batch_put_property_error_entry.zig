const BatchPutPropertyError = @import("batch_put_property_error.zig").BatchPutPropertyError;

/// An object that contains information about errors returned by the
/// `BatchPutProperty` action.
pub const BatchPutPropertyErrorEntry = struct {
    /// A list of objects that contain information about errors returned by the
    /// `BatchPutProperty` action.
    errors: []const BatchPutPropertyError,

    pub const json_field_names = .{
        .errors = "errors",
    };
};
