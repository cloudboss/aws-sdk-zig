const Connection = @import("connection.zig").Connection;

pub const DeleteConnectionResponse = struct {
    /// The connection that is being deleted.
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "Connection",
    };
};
