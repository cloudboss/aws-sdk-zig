const Get = @import("get.zig").Get;

/// Specifies an item to be retrieved as part of the transaction.
pub const TransactGetItem = struct {
    /// Contains the primary key that identifies the item to get, together with the
    /// name of
    /// the table that contains the item, and optionally the specific attributes of
    /// the item to
    /// retrieve.
    get: Get,

    pub const json_field_names = .{
        .get = "Get",
    };
};
