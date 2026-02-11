const ConditionCheck = @import("condition_check.zig").ConditionCheck;
const Delete = @import("delete.zig").Delete;
const Put = @import("put.zig").Put;
const Update = @import("update.zig").Update;

/// A list of requests that can perform update, put, delete, or check operations
/// on
/// multiple items in one or more tables atomically.
pub const TransactWriteItem = struct {
    /// A request to perform a check item operation.
    condition_check: ?ConditionCheck,

    /// A request to perform a `DeleteItem` operation.
    delete: ?Delete,

    /// A request to perform a `PutItem` operation.
    put: ?Put,

    /// A request to perform an `UpdateItem` operation.
    update: ?Update,

    pub const json_field_names = .{
        .condition_check = "ConditionCheck",
        .delete = "Delete",
        .put = "Put",
        .update = "Update",
    };
};
