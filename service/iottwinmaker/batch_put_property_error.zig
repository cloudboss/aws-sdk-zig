const PropertyValueEntry = @import("property_value_entry.zig").PropertyValueEntry;

/// An error returned by the `BatchPutProperty` action.
pub const BatchPutPropertyError = struct {
    /// An object that contains information about errors returned by the
    /// `BatchPutProperty` action.
    entry: PropertyValueEntry,

    /// The error code.
    error_code: []const u8,

    /// The error message.
    error_message: []const u8,

    pub const json_field_names = .{
        .entry = "entry",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
