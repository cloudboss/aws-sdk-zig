/// The details of a resource deletion failure during a cascade deletion of the
/// domain.
pub const FailureReason = struct {
    /// The identifier of the resource that failed to delete.
    id: ?[]const u8 = null,

    /// The error message associated with the resource that failed to delete.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .message = "message",
    };
};
