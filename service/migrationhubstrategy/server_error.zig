const ServerErrorCategory = @import("server_error_category.zig").ServerErrorCategory;

/// The error in server analysis.
pub const ServerError = struct {
    /// The error category of server analysis.
    server_error_category: ?ServerErrorCategory,

    pub const json_field_names = .{
        .server_error_category = "serverErrorCategory",
    };
};
