const Cancellation = @import("cancellation.zig").Cancellation;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const UpdateParam = @import("update_param.zig").UpdateParam;
const UpdateStatus = @import("update_status.zig").UpdateStatus;
const UpdateType = @import("update_type.zig").UpdateType;

/// An object representing an asynchronous update.
pub const Update = struct {
    /// The latest cancellation information for the update. This field is present
    /// only if any
    /// cancellation is attempted for the update.
    cancellation: ?Cancellation = null,

    /// The Unix epoch timestamp at object creation.
    created_at: ?i64 = null,

    /// Any errors associated with a `Failed` update.
    errors: ?[]const ErrorDetail = null,

    /// A UUID that is used to track the update.
    id: ?[]const u8 = null,

    /// A key-value map that contains the parameters associated with the update.
    params: ?[]const UpdateParam = null,

    /// The current status of the update.
    status: ?UpdateStatus = null,

    /// The type of the update.
    @"type": ?UpdateType = null,

    pub const json_field_names = .{
        .cancellation = "cancellation",
        .created_at = "createdAt",
        .errors = "errors",
        .id = "id",
        .params = "params",
        .status = "status",
        .@"type" = "type",
    };
};
