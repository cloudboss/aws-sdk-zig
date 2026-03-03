const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Describes the status of an attempt from Amazon AppFlow to register a
/// resource.
///
/// When you run a flow that you've configured to use a metadata catalog, Amazon
/// AppFlow
/// registers a metadata table and data partitions with that catalog. This
/// operation provides the
/// status of that registration attempt. The operation also indicates how many
/// related resources
/// Amazon AppFlow created or updated.
pub const RegistrationOutput = struct {
    /// Explains the status of the registration attempt from Amazon AppFlow. If the
    /// attempt
    /// fails, the message explains why.
    message: ?[]const u8 = null,

    /// Indicates the number of resources that Amazon AppFlow created or updated.
    /// Possible
    /// resources include metadata tables and data partitions.
    result: ?[]const u8 = null,

    /// Indicates the status of the registration attempt from Amazon AppFlow.
    status: ?ExecutionStatus = null,

    pub const json_field_names = .{
        .message = "message",
        .result = "result",
        .status = "status",
    };
};
