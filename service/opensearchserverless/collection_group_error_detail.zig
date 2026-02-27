/// Error details for a collection group operation.
pub const CollectionGroupErrorDetail = struct {
    /// The error code for the request. For example, `NOT_FOUND`.
    error_code: ?[]const u8,

    /// A description of the error. For example, `The specified Collection Group is
    /// not found.`
    error_message: ?[]const u8,

    /// If the request contains collection group IDs, the response includes the IDs
    /// provided in the request.
    id: ?[]const u8,

    /// If the request contains collection group names, the response includes the
    /// names provided in the request.
    name: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
        .name = "name",
    };
};
