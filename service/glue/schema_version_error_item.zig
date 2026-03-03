const ErrorDetails = @import("error_details.zig").ErrorDetails;

/// An object that contains the error details for an operation on a schema
/// version.
pub const SchemaVersionErrorItem = struct {
    /// The details of the error for the schema version.
    error_details: ?ErrorDetails = null,

    /// The version number of the schema.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .error_details = "ErrorDetails",
        .version_number = "VersionNumber",
    };
};
