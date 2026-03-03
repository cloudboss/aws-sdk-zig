const DeleteBehavior = @import("delete_behavior.zig").DeleteBehavior;
const UpdateBehavior = @import("update_behavior.zig").UpdateBehavior;

/// A policy that specifies update and deletion behaviors for the crawler.
pub const SchemaChangePolicy = struct {
    /// The deletion behavior when the crawler finds a deleted object.
    delete_behavior: ?DeleteBehavior = null,

    /// The update behavior when the crawler finds a changed schema.
    update_behavior: ?UpdateBehavior = null,

    pub const json_field_names = .{
        .delete_behavior = "DeleteBehavior",
        .update_behavior = "UpdateBehavior",
    };
};
