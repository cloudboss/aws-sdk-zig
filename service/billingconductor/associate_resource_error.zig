const AssociateResourceErrorReason = @import("associate_resource_error_reason.zig").AssociateResourceErrorReason;

/// A representation of a resource association error.
pub const AssociateResourceError = struct {
    /// The reason why the resource association failed.
    message: ?[]const u8 = null,

    /// A static error code that's used to classify the type of failure.
    reason: ?AssociateResourceErrorReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};
