const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const UpdateParam = @import("update_param.zig").UpdateParam;
const UpdateStatus = @import("update_status.zig").UpdateStatus;
const UpdateType = @import("update_type.zig").UpdateType;

/// An object representing an asynchronous update.
pub const Update = struct {
    /// The Unix epoch timestamp at object creation.
    created_at: ?i64,

    /// Any errors associated with a `Failed` update.
    errors: ?[]const ErrorDetail,

    /// A UUID that is used to track the update.
    id: ?[]const u8,

    /// A key-value map that contains the parameters associated with the update.
    params: ?[]const UpdateParam,

    /// The current status of the update.
    status: ?UpdateStatus,

    /// The type of the update.
    @"type": ?UpdateType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .errors = "errors",
        .id = "id",
        .params = "params",
        .status = "status",
        .@"type" = "type",
    };
};
